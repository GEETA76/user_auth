class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user

  def index
    if @user
      posts = @user.posts
      render json: { posts: posts }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    @user = User.find_by(token: token) if token.present?
  end
end
