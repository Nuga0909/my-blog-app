class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create, :index]
  before_action :set_user, only: [:new, :create, :index]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @user.comments.build(comment_params)
    @comment.post = @post

    respond_to do |format|
      if @comment.save
        format.html do
          flash[:success] = 'Comment created successfully'
          redirect_to user_post_path(params[:user_id], @comment.post_id)
        end
        format.json { render json: @comment, status: :created }
      else
        format.html do
          flash[:error] = 'Something went wrong.'
          puts @comment.errors.full_messages
          render :new
        end
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # API endpoint to list all comments for a user's post
  def index
    @comments = @post.comments
    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_user
    @user = @post.author
  end
end
