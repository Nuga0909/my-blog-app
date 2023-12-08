class PostsController < ApplicationController
  def index
        @user = User.find(params[:user_id])	      @user = User.find(params[:user_id])
        @posts = @user.posts 	      @posts = @user.posts

    end
    end	

    def show
    def show; 	      logger.debug(params)
        logger.debug(params)	      @user = User.find(params[:user_id])
        @user = User.find(params[:user_id])	      @post = @user.posts.find(params[:id])
        @post = @user.posts.find(params[:id])	      @comments = @post.comments
        @comments = @post.comments	    end
    end	
end	    def new
      @user = current_user
      @post = Post.new
    end

    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to user_posts_path, notice: 'Post was successfully created.'
      else
        flash.now[:alert] = 'Something Wrong, Cannot create a new post'
        render :new
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :text, :user_id)
    end
  end
  