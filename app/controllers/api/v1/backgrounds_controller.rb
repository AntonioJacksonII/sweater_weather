class Api::V1::BackgroundsController < ApplicationController

  def index
    location = backgrounds_params[:location]
    search_results = SearchResults.new
    background_results = search_results.weather_background_image(location)
    background = Background.new(background_results)
    render json: BackgroundSerializer.new(background)
  end

  private

  def backgrounds_params
    params.permit(:location)
  end
end
