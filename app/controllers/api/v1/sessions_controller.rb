class Api::V1::SessionsController < ApplicationController
  def create
    begin
      key = SessionSignature.generate_token(params[:key])
      render json: JsonCustomResponse.reformat(key, "", 201), status: :created
    rescue => e
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
    end
  end
end
