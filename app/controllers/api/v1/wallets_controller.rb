class Api::V1::WalletsController < ApplicationController
  before_action :set_wallet, only: %i[show deposit withdraw]
  
  def index
    @wallets = Wallet.all
    render json: JsonCustomResponse.reformat(@wallets, '', 200), status: :ok
  end

  def show
    render json: JsonCustomResponse.reformat(@wallet, '', 200), status: :ok
  end

  def deposit
    begin
      ActiveRecord::Base.transaction do
        @wallet = Wallet.find(params[:id])
        @wallet.deposit(params[:amount], params[:message])
        render json: JsonCustomResponse.reformat(@wallet.transactions.last, "", 201), status: :created
      end
    rescue => e
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
    end
  end

  def withdraw
    begin
      ActiveRecord::Base.transaction do
        @wallet = Wallet.find(params[:id])
        @wallet.withdraw(params[:amount], params[:message])
        render json: JsonCustomResponse.reformat(@wallet.transactions.last, "", 201), status: :created
      end
    rescue => e
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
    end
  end

  private

  def set_wallet
    begin
      @wallet = Wallet.find(params[:id])
    rescue => e
      render json: JsonCustomResponse.reformat('', e.message, 422), status: :unprocessable_entity
    end
  end
end
