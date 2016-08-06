module SessionsHelper

  def login(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def logout
    current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    self.current_user = nil
  end

  def redirect_back_or_to(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to login_url, notice: "Please log in."
    end
  end

  def required_login
    redirect_to login_path, notice: "Please log in." unless signed_in?
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

end
