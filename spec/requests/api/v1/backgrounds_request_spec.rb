require 'rails_helper'

describe "Backgrounds API" do
  it "returns the url to an appropriate background image for a location" do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    background = json[:data]

    expect(background[:type]).to eq('background')
    expect(background[:attributes].keys.count).to eq(1)
    expect(background[:attributes]).to have_key(:url)
    expect(background[:attributes][:url]).to_not be_empty
  end
end
