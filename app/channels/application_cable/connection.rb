module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = current_user
    end

    private

    def current_user
      @current_user ||= User.find_by(token: token)
    end

    def token
      cookies.signed[:user_token]
    end
  end
end
