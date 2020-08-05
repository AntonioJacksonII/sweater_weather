class Api::V1::RoadTripController < ApplicationController

  def create
    location = route_params[:origin]
    destination = route_params[:destination]
    search_results = SearchResults.new(location)
    travel_time = search_results.travel_time(destination)
    travel_forecast = search_results.travel_forecast(destination)
    road_trip = RoadTrip.new(travel_time, travel_forecast, location, destination)
    render json: RoadTripSerializer.new(road_trip)
  end

  private

  def route_params
    params.permit(:origin, :destination, :api_key)
  end
end
