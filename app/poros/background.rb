class Background
  attr_reader :id,
              :url

  def initialize(api_data)
    @id = nil
    @url = api_data[:results].first[:urls][:raw]
  end
end
