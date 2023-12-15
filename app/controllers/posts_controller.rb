class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:index, :show, :new, :create]

  def index
    @posts = @user.posts

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = @user.posts.find(params[:id])
    @comments = @post.comments

    respond_to do |format|
      format.html
      format.json { render json: { post: @post, comments: @comments } }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created }
      else
        format.html do
          flash.now[:alert] = 'Something Wrong, Cannot create a new post'
          render :new
        end
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :user_id)
  end

  def set_user
    @user = if params[:user_id]
              User.find(params[:user_id])
            else
              current_user
            end
  end
end
