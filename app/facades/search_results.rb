class SearchResults
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def lat_long
    json = MapquestService.new.get_lat_long(location)
    {name: location,
     latitude: json[:results].first[:locations].first[:latLng][:lat],
     longitude: json[:results].first[:locations].first[:latLng][:lng]}
  end

  def open_weather_forecast(coordinates)
    OpenweatherService.new.get_forecast(coordinates)
  end

  def weather_background_image
    weather = OpenweatherService.new.get_forecast(lat_long)[:current][:weather].first[:main]
    search_query = @location.split(",").first + " #{weather}"
    UnsplashService.new.get_weather_image(search_query)
  end
end
