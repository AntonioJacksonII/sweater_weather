class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    elsif user
      render json: "The entered password is incorrect for the entered email address", status: 400
    else
      render json: "The entered email address does not identify a user", status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
