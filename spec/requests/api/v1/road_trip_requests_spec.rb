require 'rails_helper'

describe "Login Request API" do
  it "returns the road trip information" do
    user_params = {"email": "whatever@example.com",
                   "password": "password",
                   "password_confirmation": "password"}
    post '/api/v1/users', params: user_params
    expect(response.status).to eq(201)
    post "/api/v1/sessions", params: user_params
    expect(response.status).to eq(200)

    user = User.last
    api_key = user.api_key
    road_trip_params = {"origin": "Denver,CO",
                        "destination": "Pueblo,CO",
                        "api_key": api_key
                        }
    post "/api/v1/road_trip", params: road_trip_params

    expect(response.status).to eq(200)

    json = JSON.parse(response.body, symbolize_names: true)
    road_trip = json[:data]

    expect(road_trip.keys.count).to eq(3)
    expect(road_trip[:type]).to eq('road_trip')
    expect(road_trip[:attributes].keys.count).to eq(4)
    expect(road_trip[:attributes]).to have_key(:origin)
    expect(road_trip[:attributes][:origin]).to_not be_empty
    expect(road_trip[:attributes]).to have_key(:destination)
    expect(road_trip[:attributes][:destination]).to_not be_empty
    expect(road_trip[:attributes]).to have_key(:travel_time)
    expect(road_trip[:attributes][:travel_time]).to_not be_empty
    expect(road_trip[:attributes]).to have_key(:forecast)
    expect(road_trip[:attributes][:forecast]).to_not be_empty
    expect(road_trip[:attributes][:forecast].keys.count).to eq(2)
    expect(road_trip[:attributes][:forecast]).to have_key(:temp)
    expect(road_trip[:attributes][:forecast][:temp]).to be_a Float
    expect(road_trip[:attributes][:forecast]).to have_key(:description)
    expect(road_trip[:attributes][:forecast][:description]).to_not be_empty
  end

  it "returns a 401 status code for no api_key or incorrect api_key" do
    road_trip_params = {"origin": "Denver,CO",
                        "destination": "Pueblo,CO",
                        "api_key": "1"
                        }
    post "/api/v1/road_trip", params: road_trip_params

    expect(response.status).to eq(401)
    expect(response.body).to eq('Unauthorized')

    road_trip_params = {"origin": "Denver,CO",
                        "destination": "Pueblo,CO",
                        "api_key": ""
                        }
    post "/api/v1/road_trip", params: road_trip_params
    expect(response.status).to eq(401)
    expect(response.body).to eq('Unauthorized')
  end
end
