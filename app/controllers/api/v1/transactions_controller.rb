class Api::V1::TransactionsController < ApplicationController
  before_action :set_wallet, only: %i[show]
  before_action :validate_params, only: %i[create]

  def index
    @transactions = Transaction.all
    render json: JsonCustomResponse.reformat(@transactions, "", 200), status: :ok
  end

  def show
    render json: JsonCustomResponse.reformat(@wallet.transactions, "", 200)
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @wallet = Wallet.find(params[:wallet_id])

        # Create the transaction within the transaction block
        # @wallet.transactions.create!(transactions_type: params[:transactions_type], amount: params[:amount])
        @wallet.transactions.create!(transaction_params)
    
        # If successful, respond with the created transaction
        render json: JsonCustomResponse.reformat(@wallet.transactions.last, "", 201), status: :created
      end

    rescue ActiveRecord::RecordNotFound
      # Handle case where the wallet is not found
      render json: JsonCustomResponse.reformat("", "Wallet not found", 404), status: :not_found
    rescue ActiveRecord::RecordInvalid => e
      # Handle case where the transaction creation fails due to validation
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
    rescue => e
      # Handle any other unforeseen errors
      render json: JsonCustomResponse.reformat("", e.message, 500), status: :internal_server_error
    end
  end

  private

  def set_wallet
    begin
      @wallet = Wallet.find(params[:wallet_id])
    rescue => e
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
    end
  end

  def transaction_params
    params.required(:transaction).permit(:wallet_id, :amount, :transactions_type)
  end

  def validate_params
    if params[:wallet_id].blank? or params[:amount].blank? or params[:transactions_type].blank?
      render json: JsonCustomResponse.reformat("", "Field is required, please check again", 422)
    end
  end
end
