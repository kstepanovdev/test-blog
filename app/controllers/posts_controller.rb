class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was succesfully created" }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end

end
