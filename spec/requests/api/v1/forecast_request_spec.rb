require 'rails_helper'

describe "Forecast API" do
  it "retrieves the latitude, longitude, current weather, and forecasts for the provided location" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    forecast = json[:data]

    expect(forecast[:type]).to eq('forecast')
    expect(forecast[:attributes][:location]).to eq('denver,co')
    expect(forecast[:attributes][:latitude]).to eq(39.74)
    expect(forecast[:attributes][:longitude]).to eq(-104.98)
    expect(forecast[:attributes][:current_weather]).to_not be_empty
    expect(forecast[:attributes][:hourly_forecast]).to_not be_empty
    expect(forecast[:attributes][:daily_forecast]).to_not be_empty
  end
end
