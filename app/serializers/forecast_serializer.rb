class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location, :latitude, :longitude, :current_weather, :hourly_forecast, :daily_forecast
end
