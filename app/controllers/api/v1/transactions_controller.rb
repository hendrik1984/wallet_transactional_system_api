class Api::V1::TransactionsController < ApplicationController
  before_action :validate_params, only: %i[create]
  before_action :set_wallet, only: %i[show create]
  
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
        # Create the transaction within the transaction block
        @wallet.transactions.create!(transaction_params)
    
        # If successful, respond with the created transaction
        render json: JsonCustomResponse.reformat(@wallet.transactions.last, "", 201), status: :created
      end
    rescue => e
      # Handle any other unforeseen errors
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
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
    params.permit(:wallet_id, :amount, :transactions_type)
  end

  def validate_params
    list_params = [:wallet_id, :amount, :transactions_type]
    list_params.each do |list|
      unless params.include?(list)
        render json: JsonCustomResponse.reformat("", "Field '#{list}' is required, please check again", 422), status: :unprocessable_entity 
      end
    end
  end
end
