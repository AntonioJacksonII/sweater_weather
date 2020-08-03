class Trails
  attr_reader :id,
              :location,
              :forecast,
              :trails

  def initialize(location, forecast, trails)
    @id = nil
    @location = location
    @forecast = forecast
    @trails = Trail.all
  end
end
