class CommentsController < ApplicationController
  before_action :require_login
  
  def index
    @comments = Comment.all
  end

  def show
  end

  def edit
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: "Comment was succesfully created" }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end 

end
