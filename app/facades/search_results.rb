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
    results = json[:trails]
    results.map do |trail|
      clean_trail(trail)
    end
  end

  private

  def clean_trail(trail)
    clean_hash = {}
    clean_hash[:name]
    clean_hash[:summary]
    clean_hash[:difficulty]
    clean_hash[:location]

    require "pry"; binding.pry
  end
end
