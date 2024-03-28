class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = @user.posts
  end

  private

  def require_login
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    else
      render json: { error: 'You must be logged in to access this resource' }, status: :unauthorized
    end
  end
end