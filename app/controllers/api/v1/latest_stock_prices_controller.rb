class Api::V1::LatestStockPricesController < ApplicationController
  before_action :authorization, only: %i[price prices price_all]
  before_action :request_headers_check, only: %i[price prices price_all]

  def price
    begin
      api_key = request.headers["x-rapidapi-key"]
      client = LatestStockPrice::Client.new(api_key)
      price = client.price
      render json: JsonCustomResponse.reformat(JSON.parse(price), "", 200), status: :ok
    rescue => e
      render json: {"error": e.message}, status: :unprocessable_entity
    end
  end

  def prices
    begin
      api_key = request.headers["x-rapidapi-key"]
      client = LatestStockPrice::Client.new(api_key)
      prices = client.price
      render json: JsonCustomResponse.reformat(JSON.parse(prices), "", 200), status: :ok
    rescue => e
      render json: {"error": e.message}, status: :unprocessable_entity
    end
  end

  def price_all
    begin
      api_key = request.headers["x-rapidapi-key"]
      client = LatestStockPrice::Client.new(api_key)
      price_all = client.price_all
      render json: JsonCustomResponse.reformat(JSON.parse(price_all), "", 200), status: :ok
    rescue => e
      render json: {"error": e.message}, status: :unprocessable_entity
    end
  end

  private
  def request_headers_check
  end
end
