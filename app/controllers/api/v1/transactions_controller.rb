class Api::V1::TransactionsController < ApplicationController
  before_action :authorization, only: %i[index show set_wallet]
  before_action :set_wallet, only: %i[show]
  
  def index
    @transactions = Transaction.all
    render json: JsonCustomResponse.reformat(@transactions, "", 200), status: :ok
  end

  def show
    render json: JsonCustomResponse.reformat(@wallet.transactions, "", 200)
  end

  private

  def set_wallet
    begin
      @wallet = Wallet.find(params[:wallet_id])
    rescue => e
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
    end
  end
end
