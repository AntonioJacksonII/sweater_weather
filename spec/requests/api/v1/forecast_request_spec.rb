require 'rails_helper'

describe "Forecast API" do
  it "retrieves the latitude and longitude for the provided location" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
  end
end
