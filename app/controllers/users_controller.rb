class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        login @user
        format.html { redirect_to @user, notice: "User was succesfully created" }
      else
        format.html { render :new }
      end
    end
  end 

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
