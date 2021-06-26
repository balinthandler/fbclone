class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
    @users = User.all
    @post = Post.new
    @incoming_request = Invitation.where(friend_id: current_user.id, confirmed: false)
  end
  
  def show
  end

  def new
  end

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      redirect_to root_path
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def posts_params
    params.require(:post).permit(:body)
  end

end
