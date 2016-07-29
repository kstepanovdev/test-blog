class SessionsController < ApplicationController 

  def new
  end

  def create
    user = User.find_by(email: params[:email]) 
    if user && user.authenticate(params[:password])
      login user
      redirect_to posts_path 
    else
      flash.now[:error] = "Invalid email/password combination."
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end

