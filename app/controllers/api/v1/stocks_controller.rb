class Api::V1::StocksController < ApplicationController
  before_action :set_stock, only: %i[show]
  before_action :fields_allowed, only: %i[create]
  
  def index
    @stock = Stock.all
    render json: JsonCustomResponse.reformat(@stocks, "", 200), status: :ok
  end

  def show
    render json: JsonCustomResponse.reformat(@stock, "", 200), status: :ok
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @stock = Stock.create!(team_params)
        render json: JsonCustomResponse.reformat(@stock, "", 201), status: :created
      end
    rescue => e
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
    end
  end

  private

  def set_team
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.required(:team).permit(:name)
  end

  def fields_allowed
    list_params = [:name]
    list_params.each do |list|
      unless params.include?(list)
        render json: JsonCustomResponse.reformat("", "Field '#{list}' is required, please check again", 422), status: :unprocessable_entity 
      end
    end
  end
end
