class CommentsController < ApplicationController
  before_action :signed_in_user
  before_action :fetch_comment, only: [:edit, :update, :destroy]

  def edit
  end

  def new
    @comment = current_user.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.create!(comment_params)
    if @comment.save
      redirect_back_or_to @comment.post
    else
      render :new
    end
  end

  def update
    if @comment.update!(comment_params)
      redirect_back_or_to @comment.post
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to @comment.post }
        kformat.js {}
      end
    end
  end

  private
  def fetch_comment
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end