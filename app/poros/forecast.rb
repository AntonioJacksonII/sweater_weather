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
    @daily_forecast = clean_daily_forecast(forecast)
  end

  def clean_current_weather(forecast)
    forecast[:current][:weather] = forecast[:current][:weather].first.without(:id)
    forecast[:current].without(:pressure, :dew_point, :clouds, :wind_speed, :wind_deg, :wind_gust)
  end

  def clean_hourly_forecast(forecast)
    forecast[:hourly].take(8).map do |hour_forecast|
      hour_forecast[:weather] = hour_forecast[:weather].first.slice(:icon)
      hour_forecast.slice(:dt, :temp, :weather)
    end
  end

  def clean_daily_forecast(forecast)
    forecast[:daily].take(6).map do |day_forecast|
      day_forecast[:temp] = day_forecast[:temp].slice(:min, :max)
      day_forecast[:weather] = day_forecast[:weather].first.slice(:main, :icon)
      day_forecast.slice(:dt, :temp, :weather, :rain)
    end
  end
end
