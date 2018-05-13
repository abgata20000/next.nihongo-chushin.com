class ApplicationController < ActionController::Base
  helper Webpacker::Helper
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :set_request_variant


  private

  def logged_in_check
    return if logged_in?
    redirect_to signin_path
  end

  def set_request_variant
    request.variant = request.device_variant
  end
end
