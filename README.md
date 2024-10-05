# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
** ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-linux]

* Rails version
** Rails 7.0.8.4

* Database
** database info postgresql
** step to follow for first time:
*** open terminal run command "rails db:create db:migrate"

Session info
* the session will use rails credential file as part of code and it use parameter 'api' and sub parameter 'key' and 'timeout'. 
** to edit this file run this code on your terminal under your project
  Command: EDITOR="code --wait" bin/rails credentials:edit
* session in this project will based on generate token only without save any data into database.
** to get the token access go to url [post] localhost:3000/api/v1/sessions and fill the body with json params
Request:
{
  "key": "fill this info with key from Rails credential api key"
}

Response:
{
    "data": "response_token",
    "error": "",
    "status_code": 201
}

after that use the data 'response_token' and fill into api headers Authorization to access the api. 

Token is have a timeout 30 minutes and can be configuration in Rails credential file