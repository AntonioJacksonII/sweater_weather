require 'rails_helper'

describe UnsplashService do
  context "instance methods" do
    context "#get_weather_image" do
      it "returns the url for an image" do
        service = UnsplashService.new
        search_query = "denver Clouds"
        results = service.get_weather_image(search_query)

        expect(results).to be_a Hash
        expect(results).to have_key(:results)
        expect(results[:results]).to be_an Array
        expect(results[:results].first).to have_key(:urls)
        expect(results[:results].first[:urls]).to have_key(:raw)
        expect(results[:results].first[:urls][:raw]).to_not be_empty
      end
    end
  end
end
