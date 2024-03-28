class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user && authenticate_user(params[:user][:password])
      update_user_token
      render json: { message: 'Login successful', user_id: @user.id, token: @user.token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def authenticate_user(password)
   (password == @user.password_digest)
  end

  def update_user_token
    @user.token = generate_token
    @user.update_column(:token, @user.token)
  end

  def generate_token
    SecureRandom.hex(16)
  end
end
