class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @user = @post.author
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @user.comments.build(comment_params)
    @comment.post = @post

    if @comment.save
      flash[:success] = 'Comment created successfully'
      redirect_to user_post_path(params[:user_id], @comment.post_id)
    else
      flash[:error] = 'Something went wrong.'
      puts @comment.errors.full_messages
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
