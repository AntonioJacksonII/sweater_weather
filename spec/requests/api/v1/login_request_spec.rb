require 'rails_helper'

describe "Login Request API" do
  before :each do
    user_params = {"email": "whatever@example.com",
                   "password": "password",
                   "password_confirmation": "password"}
    post '/api/v1/users', params: user_params
    expect(response.status).to eq(201)
  end

  it "returns the user's api key for successful requests" do
    user_params = {"email": "whatever@example.com",
                   "password": "password",
                   "password_confirmation": "password"}

    post "/api/v1/sessions", params: user_params

    expect(response.status).to eq(200)
    
    json = JSON.parse(response.body, symbolize_names: true)
    user = json[:data]

    expect(user.keys.count).to eq(3)
    expect(user[:type]).to eq('users')
    expect(user).to have_key(:id)
    expect(user).to have_key(:attributes)
    expect(user[:attributes].keys.count).to eq(2)
    expect(user[:attributes]).to have_key(:email)
    expect(user[:attributes]).to have_key(:api_key)
    expect(user[:attributes][:api_key]).to_not be_empty
    expect(user[:attributes][:email]).to_not be_empty
  end
end
