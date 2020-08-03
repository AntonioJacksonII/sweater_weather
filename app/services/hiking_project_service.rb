class HikingProjectService

  def conn
    Faraday.new('https://www.hikingproject.com') do |faraday|
      faraday.params['key'] = ENV['HIKING_PROJECT_API_KEY']
    end
  end

  def get_trails(coordinates)
    response = conn.get('/data/get-trails') do |req|
      req.params['lat'] = coordinates[:latitude]
      req.params['lon'] = coordinates[:longitude]
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
