class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    password = (@user.password == @user.password_digest)

    if password && @user.save
      session[:user_id] = @user.id
      redirect_to posts_path, notice: 'User successfully created and logged in.'
    else
      flash[:notice] = 'Password does not match or user could not be saved.'
      render :new
    end
  end

  def login
  end

  def authenticate
    @user = User.find_by(email: params[:email])
    password = (params[:password] == @user&.password_digest)
    if @user && password
      session[:user_id] = @user.id
      redirect_to posts_path, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid email or password.'
      render :login
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_digest)
  end
end
