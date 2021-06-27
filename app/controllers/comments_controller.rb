class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comments_params)
    if @comment.save
      redirect_to root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to root_path
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:post_id, :body)
  end

end
