class SessionsController < ApplicationController 

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) 
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_back_or_to user    
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

