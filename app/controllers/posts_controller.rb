class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    friends_1 = Invitation.where(friend_id: current_user.id, confirmed: true).pluck('user_id')
    friends_2 = Invitation.where(user_id: current_user.id, confirmed: true).pluck('friend_id')
    friends_ids = friends_1 + friends_2 + [current_user.id]

    @posts = Post.where(user_id: friends_ids)
    @users = User.all
    @post = Post.new
    @comment = Comment.new
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
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to root_path
    end
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
