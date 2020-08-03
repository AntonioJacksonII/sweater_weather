class Trail
  attr_reader :id,
              :location,
              :forecast

  def initialize(location, forecast)
    @id = nil
    @location = location
    @forecast = forecast
  end
end
