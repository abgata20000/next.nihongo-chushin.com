class ApplicationController < ActionController::Base
  helper Webpacker::Helper
  include SessionsHelper
  protect_from_forgery with: :exception


  private

  def logged_in_check
    return if logged_in?
    redirect_to signin_path
  end
end
