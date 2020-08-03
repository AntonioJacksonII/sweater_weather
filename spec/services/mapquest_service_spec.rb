require 'rails_helper'

describe MapquestService do
  context "instance methods" do
    context "#get_lat_long" do
      it "returns the latitude and longitude for the input location" do
        service = MapquestService.new
        results = service.get_lat_long("denver,co")
        expect(results).to be_a Hash
        expect(results[:results]).to be_an Array
        latitude = results[:results].first[:locations].first[:latLng][:lat]
        longitude = results[:results].first[:locations].first[:latLng][:lng]

        expect(latitude).to eq(39.738453)
        expect(longitude).to eq(-104.984853)
      end
    end
  end
end
