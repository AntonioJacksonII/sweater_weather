require 'rails_helper'

describe "Forecast API" do
  it "retrieves the latitude, longitude, current weather, and forecasts for the provided location" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    forecast = json[:data]

    expect(forecast[:type]).to eq('forecast')
    expect(forecast[:attributes].keys.count).to eq(7)
    expect(forecast[:attributes]).to have_key(:location)
    expect(forecast[:attributes]).to have_key(:latitude)
    expect(forecast[:attributes]).to have_key(:longitude)
    expect(forecast[:attributes]).to have_key(:current_weather)
    expect(forecast[:attributes]).to have_key(:hourly_forecast)
    expect(forecast[:attributes]).to have_key(:daily_forecast)
    expect(forecast[:attributes][:location]).to eq('denver,co')
    expect(forecast[:attributes][:latitude]).to eq(39.74)
    expect(forecast[:attributes][:longitude]).to eq(-104.98)
    expect(forecast[:attributes][:current_weather]).to_not be_empty
    expect(forecast[:attributes][:current_weather]).to have_key(:dt)
    expect(forecast[:attributes][:current_weather]).to have_key(:sunrise)
    expect(forecast[:attributes][:current_weather]).to have_key(:sunset)
    expect(forecast[:attributes][:current_weather]).to have_key(:temp)
    expect(forecast[:attributes][:current_weather]).to have_key(:feels_like)
    expect(forecast[:attributes][:current_weather]).to have_key(:humidity)
    expect(forecast[:attributes][:current_weather]).to have_key(:uvi)
    expect(forecast[:attributes][:current_weather]).to have_key(:visibility)
    expect(forecast[:attributes][:current_weather]).to have_key(:weather)
    expect(forecast[:attributes][:current_weather][:weather]).to have_key(:main)
    expect(forecast[:attributes][:current_weather][:weather]).to have_key(:description)
    expect(forecast[:attributes][:current_weather][:weather]).to have_key(:icon)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:pressure)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:dew_point)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:clouds)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:wind_speed)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:wind_deg)
    expect(forecast[:attributes][:current_weather]).to_not have_key(:wind_gust)
    expect(forecast[:attributes][:hourly_forecast]).to_not be_empty
    expect(forecast[:attributes][:hourly_forecast].count).to eq(8)
    expect(forecast[:attributes][:hourly_forecast].first.keys.count).to eq(3)
    expect(forecast[:attributes][:hourly_forecast].first).to have_key(:dt)
    expect(forecast[:attributes][:hourly_forecast].first).to have_key(:temp)
    expect(forecast[:attributes][:hourly_forecast].first).to have_key(:weather)
    expect(forecast[:attributes][:hourly_forecast].first[:weather].keys.count).to eq(1)
    expect(forecast[:attributes][:hourly_forecast].first[:weather]).to have_key(:icon)
    expect(forecast[:attributes][:hourly_forecast].first[:weather][:icon]).to_not be_empty
    expect(forecast[:attributes][:daily_forecast]).to_not be_empty
    expect(forecast[:attributes][:daily_forecast].count).to eq(6)
    expect(forecast[:attributes][:daily_forecast].first).to have_key(:dt)
    expect(forecast[:attributes][:daily_forecast].first).to have_key(:temp)
    expect(forecast[:attributes][:daily_forecast].first).to have_key(:weather)
    expect(forecast[:attributes][:daily_forecast].first[:temp].keys.count).to eq(2)
    expect(forecast[:attributes][:daily_forecast].first[:temp]).to have_key(:min)
    expect(forecast[:attributes][:daily_forecast].first[:temp]).to have_key(:max)
    expect(forecast[:attributes][:daily_forecast].first[:weather].keys.count).to eq(2)
    expect(forecast[:attributes][:daily_forecast].first[:weather]).to have_key(:main)
    expect(forecast[:attributes][:daily_forecast].first[:weather]).to have_key(:icon)
  end
end
