class Api::V1::WalletsController < ApplicationController
  before_action :set_wallet, only: %i[show]
  
  def index
    @wallets = Wallet.all
    render json: JsonCustomResponse.reformat(@wallets, '', 200), status: :ok
  end

  def show
    render json: JsonCustomResponse.reformat(@wallet, '', 200), status: :ok
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
