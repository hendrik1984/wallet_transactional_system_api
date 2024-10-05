class Api::V1::LatestStockPricesController < ApplicationController
  before_action :authorization, only: %i[price prices price_all]
  before_action :third_party_headers_check
  before_action :fields_allowed, only: %i[price prices]

  def price
    begin
      api_key = request.headers["x-rapidapi-key"]
      client = LatestStockPrice::Client.new(api_key)
      price = client.prices(params["symbols"])
      data = JSON.parse(price)
      render json: JsonCustomResponse.reformat(data[0], "", 200), status: :ok
    rescue => e
      render json: {"error": e.message}, status: :unprocessable_entity
    end
  end

  def prices
    begin
      api_key = request.headers["x-rapidapi-key"]
      client = LatestStockPrice::Client.new(api_key)
      prices = client.prices(params["symbols"])
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
  def third_party_headers_check
    render json: JsonCustomResponse.reformat("", "request header x-rapidapi-key is required, please check again", 422), status: :unprocessable_entity unless request.headers.include?('x-rapidapi-key')
  end

  def fields_allowed
    list_params = [:symbols]
    list_params.each do |list|
      unless params.include?(list)
        render json: JsonCustomResponse.reformat("", "Field '#{list}' is required, please check again", 422), status: :unprocessable_entity 
      end
    end
  end
end
