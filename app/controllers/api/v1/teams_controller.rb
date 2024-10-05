class Api::V1::TeamsController < ApplicationController
  before_action :authorization, only: %i[index show create]
  before_action :set_team, only: %i[show]
  before_action :fields_allowed, only: %i[create]
  
  def index
    @teams = Team.all
    render json: JsonCustomResponse.reformat(@teams, "", 200), status: :ok
  end

  def show
    render json: JsonCustomResponse.reformat(@team, "", 200), status: :ok
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @team = Team.create!(team_params)
        render json: JsonCustomResponse.reformat(@team, "", 201), status: :created
      end
    rescue => e
      render json: JsonCustomResponse.reformat("", e.message, 422), status: :unprocessable_entity
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
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
