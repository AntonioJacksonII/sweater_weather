class SearchResults
  attr_reader :location

  def lat_long(location)
    json = MapquestService.new.get_lat_long(location)
    {name: location,
     latitude: json[:results].first[:locations].first[:latLng][:lat],
     longitude: json[:results].first[:locations].first[:latLng][:lng]}
  end

  def open_weather_forecast(coordinates)
    OpenweatherService.new.get_forecast(coordinates)
  end

  def weather_background_image(location)
    weather = OpenweatherService.new.get_forecast(lat_long(location))[:current][:weather].first[:main]
    search_query = location.split(",").first + " #{weather}"
    UnsplashService.new.get_weather_image(search_query)
  end

  def travel_time(origin, destination)
    MapquestService.new.get_travel_time(origin, destination)
  end

  def travel_forecast(destination)
    destination_coordinates = lat_long(destination)
    destination_weather = OpenweatherService.new.get_forecast(destination_coordinates)[:current]
    {temp: destination_weather[:temp], description: destination_weather[:weather].first[:description]}
  end
end
