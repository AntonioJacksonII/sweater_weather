require 'rails_helper'

describe "Trails API" do
  it "returns the forecast for the start location and trail attributes" do
    get '/api/v1/trails?location=denver,co'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    response = json[:data]

    expect(response[:type]).to eq('trail')
    expect(response[:attributes][:location]).to eq('denver,co')
    expect(response[:attributes][:forecast]).to_not be_empty
    expect(response[:attributes][:forecast][:summary]).to_not be_empty
    expect(response[:attributes][:forecast][:temperature]).to_not be_empty

    expect(response[:trails]).to be_a Array
    expect(response[:trails].first[:name]).to_not be_empty
    expect(response[:trails].first[:summary]).to_not be_empty
    expect(response[:trails].first[:difficulty]).to_not be_empty
    expect(response[:trails].first[:location]).to_not be_empty
    expect(response[:trails].first[:distance_to_trail]).to_not be_empty
  end
end
