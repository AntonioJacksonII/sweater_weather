require 'rails_helper'

describe "Trails API" do
  it "returns the forecast for the start location and trail attributes" do
    get '/api/v1/trails?location=denver,co'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    response = json[:data]

    expect(response[:type]).to eq('trail')
    expect(response[:attributes]).to have_key(:location)
    expect(response[:attributes][:location]).to eq('denver,co')
    expect(response[:attributes]).to have_key(:forecast)
    expect(response[:attributes][:forecast]).to_not be_empty
    expect(response[:attributes][:forecast]).to_not have_key(:location)
    expect(response[:attributes][:forecast]).to_not have_key(:latitude)
    expect(response[:attributes][:forecast]).to_not have_key(:longitude)
    expect(response[:attributes][:forecast]).to_not have_key(:hourly_forecast)
    expect(response[:attributes][:forecast]).to_not have_key(:daily_forecast)
    expect(response[:attributes][:forecast].keys.count).to eq(2)
    expect(response[:attributes][:forecast]).to have_key(:summary)
    expect(response[:attributes][:forecast][:summary]).to_not be_empty
    expect(response[:attributes][:forecast]).to have_key(:temperature)
    expect(response[:attributes][:forecast][:temperature]).to be_a Integer

    expect(response[:attributes][:trails]).to be_a Array
    expect(response[:attributes][:trails].first).to be_a Hash
    expect(response[:attributes][:trails].first.keys.count).to eq(5)
    expect(response[:attributes][:trails].first).to_not have_key(:type)
    expect(response[:attributes][:trails].first).to_not have_key(:stars)
    expect(response[:attributes][:trails].first).to_not have_key(:starVotes)
    expect(response[:attributes][:trails].first).to_not have_key(:url)
    expect(response[:attributes][:trails].first).to_not have_key(:conditionDate)
    expect(response[:attributes][:trails].first).to_not have_key(:ascent)
    expect(response[:attributes][:trails].first).to have_key(:name)
    expect(response[:attributes][:trails].first).to have_key(:summary)
    expect(response[:attributes][:trails].first).to have_key(:difficulty)
    expect(response[:attributes][:trails].first).to have_key(:location)
    expect(response[:attributes][:trails].first).to have_key(:distance_to_trail)
    expect(response[:attributes][:trails].first[:name]).to_not be_empty
    expect(response[:attributes][:trails].first[:summary]).to_not be_empty
    expect(response[:attributes][:trails].first[:difficulty]).to_not be_empty
    expect(response[:attributes][:trails].first[:location]).to_not be_empty
    expect(response[:attributes][:trails].first[:distance_to_trail]).to be_a Float
  end
end
