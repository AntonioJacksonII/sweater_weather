class Api::V1::TrailsController < ApplicationController

  def index
    location = params[:location]
    search_results = SearchResults.new(location)
    coordinates = search_results.lat_long
    forecast_results = search_results.open_weather_forecast(coordinates)
    trail_forecast = Forecast.new(location, forecast_results).trail_forecast
    @trails = search_results.trails(coordinates)
    render json: TrailSerializer.new(@trails)
  end
end
