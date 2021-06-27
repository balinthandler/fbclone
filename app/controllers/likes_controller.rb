class LikesController < ApplicationController

  def index
  end

  def new
  end

  def create
    @like = Like.create(like_params)
    if @like.save
      redirect_to root_path
    end
  end

  def destroy
    like = Like.where(like_params).first
    like.destroy
    redirect_to root_path
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end

end
