class Forecast
  attr_reader :id,
              :location,
              :latitude,
              :longitude,
              :current_weather,
              :hourly_forecast,
              :daily_forecast

  def initialize(location, forecast)
    @id = nil
    @location = location
    @latitude = forecast[:lat]
    @longitude = forecast[:lon]
    @current_weather = forecast[:current]
    @hourly_forecast = forecast[:hourly]
    @daily_forecast = forecast[:daily]
  end
end
