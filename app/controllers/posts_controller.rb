class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
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


end
