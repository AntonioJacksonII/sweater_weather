class Api::V1::UsersController < ApplicationController

  def create
    create_params = user_params.to_h
    create_params[:api_key] = SecureRandom.uuid
    user = User.create!(create_params)
    render json: UsersSerializer.new(user), status: :created
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
