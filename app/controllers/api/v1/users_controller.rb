class Api::V1::UsersController < ApplicationController
  before_action :authorization, only: %i[index show create set_user]
  before_action :set_user, only: %i[show]
  before_action :fields_allowed, only: %i[create]
  
  def index
    @users = User.all
    render json: JsonCustomResponse.reformat(@users, "", 200), status: :ok
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
    begin
      @user = User.find(params[:id])
    rescue => e
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
    end
  end

  def user_params
    params.required(:user).permit(:name)
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
