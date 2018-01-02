class MyPagesController < ApplicationController
  before_action :logged_in_check

  def show
  end

  def update
    if current_user.update(controller_params)
      redirect_to room_path(current_user.room)
    else
      render :show
    end
  end

  private

  def controller_params
    params.fetch(:user, {}).permit(:color, :sound)
  end

end
