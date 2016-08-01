class UsersController < ApplicationController
  before_action :fetch_user, only: [:show, :edit, :update]
  before_action :required_login, only: [:edit, :show, :update]
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show   
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_back_or_to @user, notice: "User was succesfully updated" }
        format.js
      else
        format.html { render :edit }
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        login @user
        format.html { redirect_back_or_to @user, notice: "User was succesfully created" }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  private
  def fetch_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname)
  end

  def required_login
    redirect_to login_path, notice: "Please log in." unless signed_in?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to login_url, notice: "Please log in."
    end
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

end
