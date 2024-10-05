require 'uri'
require 'net/http'

module LatestStockPrice
  class Client
    def initialize(api_key)
      @api_key = api_key
      @base_url = 'https://latest-stock-price.p.rapidapi.com'
      @host = "latest-stock-price.p.rapidapi.com"
    end

    def price(symbol)
      url = URI("#{@base_url}/equities-search?Symbols=#{symbol}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = @api_key
      request["x-rapidapi-host"] = @host

      response = http.request(request)
      return response.read_body
    end

    def prices(symbols)
      url = URI("#{@base_url}/equities-enhanced?Symbols=#{symbols}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = @api_key
      request["x-rapidapi-host"] = @host

      response = http.request(request)
      return response.read_body
    end

    def price_all
      url = URI("#{@base_url}/equities")
      
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      
      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = @api_key
      request["x-rapidapi-host"] = @host
      
      response = http.request(request)
      return response.read_body
    end
  end
end