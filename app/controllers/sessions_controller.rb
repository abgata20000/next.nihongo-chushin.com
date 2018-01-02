class SessionsController < ApplicationController
  before_action :redirect_to_root_with_logged_in, only: %w(new create)
  before_action :set_user_session

  def new
  end

  def create
    if @user_session.save
      redirect_to rooms_path
    else
      render :new
    end
  end

  def destroy
    reset_current_user
    redirect_to root_path
  end

  private

  def set_user_session
    @user_session = UserSession.new(user_session_params)
  end

  def user_session_params
    tmp = params.fetch(:user_session, {}).permit(:nickname, :icon, :color, :sound)
    tmp[:user] = current_user
    tmp
  end

  def redirect_to_root_with_logged_in
    return unless logged_in?
    redirect_to root_path
  end
end
