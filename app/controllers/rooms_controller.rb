class RoomsController < ApplicationController
  before_action :logged_in_check
  before_action :find_room, only: %w(show edit update destroy)
  before_action :set_room, only: %w(new create)
  before_action :set_room_id_to_current_user, only: %w(show)
  before_action :check_current_room, only: %w(show edit update destroy new create)
  before_action :check_room_max, only: %w(show)
  before_action :check_room_owner, only: %w(edit update)


  def index
    @rooms = Room.includes(:users).enabled.order(updated_at: :desc).limit(10).all
  end

  def show

  end

  def new

  end

  def create
    if @room.save
      current_user.into_the_room(@room)
      current_user.create_the_room_system_comment
      redirect_to room_path(@room)
    else
      render :new
    end
  end


  def leave
    if current_user.room
      current_user.leave_the_room_system_comment
      current_user.leave_room
    end
    redirect_to rooms_path
  end

  private

  def id
    params[:id]
  end

  def set_room_id_to_current_user
    return if current_user.room.present?
    current_user.into_the_room(@room)
    current_user.into_the_room_system_comment
  end

  def set_room
    @room = Room.new(controller_params)
    @room.user = current_user
  end

  def find_room
    @room = Room.find(id)
    @room.assign_attributes(controller_params)
  end

  def controller_params
    params.fetch(:room, {}).permit(:name, :num)
  end

  def check_current_room
    return if current_user.room_id == @room.id
    redirect_to rooms_path
  end

  def check_room_max
    return unless @room.max?
    redirect_to rooms_path, notice: '満室です。'
  end


  def check_room_owner
    return if current_user.room_owner?
    redirect_to room_path(current_user.room), notice: '管理者権限がありません'
  end
end
