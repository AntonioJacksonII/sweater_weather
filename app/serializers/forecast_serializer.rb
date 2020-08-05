class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location, :latitude, :longitude, :current_weather, :hourly_forecast, :daily_forecast

  attribute :current_weather do |forecast|
    forecast.current_weather[:weather] = forecast.current_weather[:weather].first.without(:id)
    forecast.current_weather.without(:pressure, :dew_point, :clouds, :wind_speed, :wind_deg, :wind_gust)
  end

  attribute :hourly_forecast do |forecast|
    forecast.hourly_forecast.take(8).map do |hour_forecast|
      hour_forecast[:weather] = hour_forecast[:weather].first.slice(:icon)
      hour_forecast.slice(:dt, :temp, :weather)
    end
  end

  attribute :daily_forecast do |forecast|
    forecast.daily_forecast.take(6).map do |day_forecast|
      day_forecast[:temp] = day_forecast[:temp].slice(:min, :max)
      day_forecast[:weather] = day_forecast[:weather].first.slice(:main, :icon)
      day_forecast.slice(:dt, :temp, :weather, :rain)
    end
  end
end
