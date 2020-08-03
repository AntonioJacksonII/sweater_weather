class Api::V1::TrailsController < ApplicationController

  def index
    location = params[:location]
    search_results = SearchResults.new(location)
    coordinates = search_results.lat_long
    forecast_results = search_results.open_weather_forecast(coordinates)
    trail_forecast = Forecast.new(location, forecast_results).trail_forecast
    @trails = Trail.new(location, trail_forecast)
    render json: TrailSerializer.new(@trails)
    require "pry"; binding.pry
  end
end
