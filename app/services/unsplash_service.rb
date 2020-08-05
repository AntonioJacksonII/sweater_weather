class UnsplashService

  def conn
    Faraday.new('https://api.unsplash.com') do |faraday|
      faraday.params['client_id'] = ENV['UNSPLASH_API_KEY']
    end
  end

  def get_weather_image(search_query)
    response = conn.get('/search/photos') do |req|
      req.params['query'] = search_query
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
