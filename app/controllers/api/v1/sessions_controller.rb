class Api::V1::SessionsController < ApplicationController

  def create
    unless user = User.find_by(email: user_params[:email])
      render json: "The entered email address does not identify a user", status: 400
    end
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    else
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
