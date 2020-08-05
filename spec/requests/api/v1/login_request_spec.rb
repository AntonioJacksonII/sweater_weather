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
                   "password": "password"}
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

  it "returns a 400 level status code for unrecognized emails" do
    user_params = {"email": "whateve@example.com",
                   "password": "password"}
    post "/api/v1/sessions", params: user_params

    expect(response.status).to eq(400)
    expect(response.body).to eq('The entered email address does not identify a user')
  end

  it "returns a 400 level status code for empty email addresses" do
    user_params = {"email": "",
                   "password": "password"}
    post "/api/v1/sessions", params: user_params

    expect(response.status).to eq(400)
    expect(response.body).to eq('The entered email address does not identify a user')
  end


    it "returns a 400 level status code for incorrect password" do
      user_params = {"email": "whatever@example.com",
                     "password": "passwor"}
      post "/api/v1/sessions", params: user_params

      expect(response.status).to eq(400)
      expect(response.body).to eq('The entered password is incorrect for the entered email address')
    end

    it "returns a 400 level status code when no password is provided" do
      user_params = {"email": "whatever@example.com",
                     "password": ""}
      post "/api/v1/sessions", params: user_params

      expect(response.status).to eq(400)
      expect(response.body).to eq('The entered password is incorrect for the entered email address')
    end

end
