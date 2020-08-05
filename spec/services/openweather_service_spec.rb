require 'rails_helper'

describe OpenweatherService do
  context "instance methods" do
    context "#get_forecast" do
      it "returns the forecast for the input coordinates" do
        service = OpenweatherService.new
        coordinates = {:name=>"denver,co", :latitude=>39.738453, :longitude=>-104.984853}
        results = service.get_forecast(coordinates)
        expect(results).to be_a Hash
        expect(results).to have_key(:lat)
        expect(results).to have_key(:lon)
        expect(results).to have_key(:current)
        expect(results[:current]).to be_a Hash
        expect(results).to have_key(:hourly)
        expect(results[:hourly].first).to be_a Hash
        expect(results).to have_key(:daily)
        expect(results[:daily].first).to be_a Hash
      end
    end
  end
end
