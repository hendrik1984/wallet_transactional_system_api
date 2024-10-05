# README
This README would normally document whatever steps are necessary to get the application up and running.

## Things you may want to cover:
* First thing first, run `bundle install` to install gem needed for this project
* Ruby version
  *  ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-linux]
* Rails version
  * Rails 7.0.8.4
  * Database
    * database: postgresql
    * step to follow for first time:
    * open terminal run command "rails db:create db:migrate"

## Session info
* The session will use rails credential file as part of code and it use parameter 'api' and sub parameter 'key' and 'timeout'.

* To edit this file run this code on your terminal under your project

* Command: 
	* `EDITOR="code --wait" bin/rails credentials:edit`

* Session in this project will based on generate token only without save any data into database.

* To get the token access go to url:
`[post] localhost:3000/api/v1/sessions` 
and fill the body with json params below
Request:
    { "key": "fill this info with key from Rails credential api key" }
Response:
    {
    "data": "response_token",
    "error": "",
    "status_code": 201
    }

after that use the data 'response_token' and fill into api headers Authorization to access the api.

* Token is have a timeout 30 minutes and can be configuration in Rails credential file

## Latest Stock Price API

* Api will Contain 3 apis to call, Price, Prices and Price_all
* Every api must have a headers Authorization and x-rapidapi-key to make a request

### List API url
* price: localhost:3000/api/v1/latest_stock_prices/price
* price: localhost:3000/api/v1/latest_stock_prices/prices
* price: localhost:3000/api/v1/latest_stock_prices/price_all

  

### For api price and prices need to send params

sample params prices

    {
    "symbols": "TATADVRA.NS,GODRCONS.NS,TVSMOTO.NS"
    }

  sample params price

    {
    "symbols": "TATADVRA.NS"
    }
