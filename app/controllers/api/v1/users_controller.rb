class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user = User.new(user_params)
    @user.token = generate_token
    password = (params[:user][:password] == @user.password_digest)

    if password && @user.save
      session[:user_id] = @user.id
      render json: { message: 'User created successfully', token: @user.token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_digest)
  end

  def generate_token
    SecureRandom.hex(16)
  end
end
