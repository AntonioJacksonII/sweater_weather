class Api::V1::RoadTripController < ApplicationController

  def create
    origin = route_params[:origin]
    destination = route_params[:destination]
    if User.valid_api_key?(route_params[:api_key])
      search_results = SearchResults.new
      travel_time = search_results.travel_time(origin, destination)
      travel_forecast = search_results.travel_forecast(destination)
      road_trip = RoadTrip.new(travel_time, travel_forecast, origin, destination)
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: "Unauthorized", status: 401
    end
  end

  private

  def route_params
    params.permit(:origin, :destination, :api_key)
  end
end
