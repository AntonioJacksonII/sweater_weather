class Trails
  attr_reader :id,
              :location,
              :forecast

  def initialize(location, forecast, trails)
    @id = nil
    @location = location
    @forecast = forecast
    @trails =
  end
end
