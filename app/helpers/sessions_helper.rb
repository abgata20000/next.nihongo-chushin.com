module SessionsHelper
  def current_user
    return @current_user if @current_user
    @current_user = User.find_by(token: session[:user_token])

    if @current_user.blank?
      @current_user = User.create!
      session[:user_token] = @current_user.token
      cookies.signed[:user_token] = @current_user.token
    end
    @current_user
  end

  def current_user=(user)
    @current_user = user
  end

  def reset_current_user
    current_user.logout
    @current_user = current_user
  end

  def logged_in?
    current_user.nickname.present?
  end
end
