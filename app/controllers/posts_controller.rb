class PostsController < ApplicationController
  before_action :fetch_post, only: [:edit, :update, :destroy]
  before_action :required_login, only: [:edit, :update, :destroy]
  before_action :signed_in_user
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = current_user.comments.new
  end

  def edit
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was succesfully created" }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if @post.update!(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.html { redirect_to posts_path }
        format.js {}
      end
    end
  end

  private
  def fetch_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :user_id, :title)
  end

end
