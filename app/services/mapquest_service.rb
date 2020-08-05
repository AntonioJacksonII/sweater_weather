class MapquestService

  def conn
    Faraday.new('http://www.mapquestapi.com') do |faraday|
      faraday.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end

  def get_lat_long(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_travel_time(origin, destination)
    response = conn.get('directions/v2/route') do |req|
      req.params['from'] = origin
      req.params['to'] = destination
    end
    JSON.parse(response.body, symbolize_names: true)[:route][:formattedTime]
  end
end
