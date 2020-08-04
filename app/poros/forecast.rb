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
    @hourly_forecast = clean_hourly_forecast(forecast)
    @daily_forecast = forecast[:daily]
  end

  def clean_current_weather(forecast)
    forecast[:current].without(:pressure, :dew_point, :clouds, :wind_speed, :wind_deg, :wind_gust)
  end

  def clean_hourly_forecast(forecast)
    forecast[:hourly].take(8).map do |hour_forecast|
      hour_forecast[:weather] = hour_forecast[:weather].first
      hour_forecast[:weather] = hour_forecast[:weather].slice(:icon)
      hour_forecast.slice(:dt, :temp, :weather)
    end
  end
end
