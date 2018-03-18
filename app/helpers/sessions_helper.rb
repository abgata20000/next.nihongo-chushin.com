module SessionsHelper
  def current_user
    return @current_user if @current_user
    @current_user = User.find_by(token: user_token)
    @current_user = User.create! if @current_user.blank?
    # セッションの有効期限を更新(永続的に利用させたい)
    cookies.signed[:user_token] = {
        value: @current_user.token,
        expires: 10.years.from_now
    }
    @current_user
  end

  def user_token
    cookies.signed[:user_token]
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
