class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
    @users = User.all
    @incoming_request = Invitation.where(friend_id: current_user.id, confirmed: false)
  end
  
  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
