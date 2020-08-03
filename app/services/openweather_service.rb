class OpenweatherService

  def conn
    Faraday.new('https://api.openweathermap.org') do |faraday|
      faraday.params['appid'] = ENV['OPENWEATHER_API_KEY']
    end
  end

  def get_forecast(coordinates)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['units'] = 'imperial'
      req.params['exclude'] = 'minutely'
      req.params['lat'] = coordinates[:latitude]
      req.params['lon'] = coordinates[:longitude]
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
