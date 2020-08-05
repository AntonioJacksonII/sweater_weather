class Background
  attr_reader :id,
              :url

  def initialize(api_data)
    @id = nil
    @url = get_url(api_data)
  end

  def get_url(api_data)
    api_data[:results].first[:urls][:raw]
  end
end
