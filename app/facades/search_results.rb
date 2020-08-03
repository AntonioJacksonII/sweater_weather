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

  def distance(from, to)
    MapquestService.new.get_distance(from, to)
  end

  def open_weather_forecast(coordinates)
    OpenweatherService.new.get_forecast(coordinates)
  end

  def trails(coordinates)
    json = HikingProjectService.new.get_trails(coordinates)
    json[:trails].map do |trail_info|
      Trail.new(trail_info)
    end
  end
end
