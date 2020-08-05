class Api::V1::ForecastController < ApplicationController

  def index
    location = forecast_params[:location]
    search_results = SearchResults.new(location)
    coordinates = search_results.lat_long(location)
    forecast_results = search_results.open_weather_forecast(coordinates)
    forecast = Forecast.new(location, forecast_results)
    render json: ForecastSerializer.new(forecast)
  end

  private

  def forecast_params
    params.permit(:location)
  end
end
