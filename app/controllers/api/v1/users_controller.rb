class Api::V1::UsersController < ApplicationController

  def create
    create_params = user_params.to_h
    create_params[:api_key] = SecureRandom.uuid
    user = User.new(create_params)
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      render json: user.errors.full_messages.first, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
