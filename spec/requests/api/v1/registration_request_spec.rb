require 'rails_helper'

describe "User Registration API" do
  it "creates a user and generates a unique api key for that user" do
    user_params = {"email": "whatever@example.com",
                   "password": "password",
                   "password_confirmation": "password"}
    post "/api/v1/users", params: user_params

    expect(response).to be_successful
    expect(response.status).to eq(201)

    json = JSON.parse(response.body, symbolize_names: true)
    user = json[:data]

    expect(user[:type]).to eq('users')
    expect(user).to have_key(:id)
    expect(user[:id]).to_not be_empty
    expect(user[:attributes].keys.count).to eq(2)
    expect(user[:attributes]).to have_key(:email)
    expect(user[:attributes][:email]).to_not be_empty
    expect(user[:attributes]).to have_key(:api_key)
    expect(user[:attributes][:api_key]).to_not be_empty
  end

  it "returns a 400 level status code for mismatched passwords and password confirmations" do
    user_params = {"email": "whatever@example.com",
                   "password": "password",
                   "password_confirmation": "passwor"}
    post "/api/v1/users", params: user_params

    expect(response.status).to eq(400)
    expect(response.body).to eq("Password confirmation doesn't match Password")

    user_params = {"email": "whatever@example.com",
                   "password": "passwor",
                   "password_confirmation": "password"}
    post "/api/v1/users", params: user_params

    expect(response.status).to eq(400)
  end

  it "returns a 400 level status code for nonunique emails" do
    user_params = {"email": "whatever@example.com",
                   "password": "password",
                   "password_confirmation": "password"}
    post "/api/v1/users", params: user_params
    post "/api/v1/users", params: user_params

    expect(response.status).to eq(400)
    expect(response.body).to eq("Email has already been taken")
  end
end
