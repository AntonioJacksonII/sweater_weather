class Api::V1::TrailsController < ApplicationController

  def index
    location = params[:location]
    search_results = SearchResults.new(location)
    coordinates = search_results.lat_long
    forecast_results = search_results.open_weather_forecast(coordinates)
    trail_results = search_results.trails(coordinates)
    require "pry"; binding.pry
    trail_forecast = Forecast.new(location, forecast_results).trail_forecast
    @trails = Trails.new(location, trail_forecast, trail_results)
    render json: TrailSerializer.new(@trails)
  end
end
