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
    @current_weather = clean_current_weather(forecast)
    @hourly_forecast = forecast[:hourly]
    @daily_forecast = forecast[:daily]
  end

  def clean_current_weather(forecast)
    forecast[:current].without(:pressure, :dew_point, :clouds, :wind_speed, :wind_deg, :wind_gust)
  end
end
