class V1::CountriesController < ApplicationController
  before_action :set_country, only: [:show, :update, :destroy]

  def index
    @countries = Country.all
    render json: @countries, status: :ok
  end

  def create
    @country = Country.new(country_params)

    if @country.save
      render json: @country, status: :created
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @country
  end

  def update
    if @country.update(country_params)
      render json: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @country.destroy
    render json: { message: "Country deleted successfully." }
  end

  private

  def set_country
    @country = Country.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Country not found' }, status: :not_found
  end

  def country_params
    params.require(:country).permit(:name)
  end
end
