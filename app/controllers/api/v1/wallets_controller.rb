class Api::V1::WalletsController < ApplicationController
  before_action :set_wallet, only: %i[show]
  
  def index
    @wallets = Wallet.all
    render json: @wallets
  end

  def show
    render json: @wallet
  end

  # def create
  #   begin
  #     @wallet = Wallet.create!(name: params[:name])
  #     render json: @wallet
  #   rescue => e
  #     render json: "Error occured with message #{e.message}".to_json
  #   end
  # end

  private

  def set_wallet
    @wallet = Wallet.find(params[:id])
  end
  
  
end
