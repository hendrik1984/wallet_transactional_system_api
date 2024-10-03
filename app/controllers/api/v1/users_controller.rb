class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :fields_allowed
  
  def index
    @users = User.all
    render json: JsonCustomResponse.reformat(@user, "", 200), status: :ok
  end

  def show
    render json: JsonCustomResponse.reformat(@user, "", 200), status: :ok
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @user = User.create!(user_params)
        render json: JsonCustomResponse.reformat(@user, "", 201), status: :created
      end
    rescue => e
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name)
  end

  def fields_allowed
    if params[:name].blank?
      render json: JsonCustomResponse.reformat("", "Field [name] is required, please check again", 422)
    end
  end
end
