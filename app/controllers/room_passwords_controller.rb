class RoomPasswordsController < ApplicationController
  before_action :find_room, only: %w(new create)
  before_action :set_room_password, only: %w(new create)


  def show

  end

  def create
    if @room_password.save
      redirect_to room_join_path(@room, password: @room_password.password)
    else
      render :new
    end
  end

  private

  def id
    params[:room_id]
  end

  def find_room
    @room = Room::ForUpdate.enabled.find(id)
  rescue => _e
    redirect_to rooms_path
  end

  def set_room_password
    @room_password = RoomPassword.new(controller_params)
  end

  def controller_params
    tmp = params.fetch(:room_password, {}).permit(:password)
    tmp[:user] = current_user
    tmp[:room] = @room
    tmp
  end
end
