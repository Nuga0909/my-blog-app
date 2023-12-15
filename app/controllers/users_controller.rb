class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts

    respond_to do |format|
      format.html
      format.json { render json: { user: @user, posts: @posts } }
    end
  end
end
