class RoomsController < ApplicationController
  before_action :logged_in_check, except: %w(index)
  before_action :find_room, only: %w(show edit update users ban_user join)
  before_action :set_room, only: %w(new create)
  before_action :check_exists_username, only: %w(join)
  before_action :check_room_max, only: %w(join)
  before_action :set_room_id_to_current_user, only: %w(join)
  before_action :check_current_room, only: %w(show edit update new create ban_user users)
  before_action :check_room_owner, only: %w(edit update ban_user)

  def index
    @rooms = Room.active_rooms
  end

  def show

  end

  def join
    redirect_to room_path(current_user.room)
  end

  def new

  end

  def create
    if @room.save
      redirect_to room_path(@room)
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @room.save
      redirect_to room_path(@room)
    else
      render :edit
    end
  end

  def leave
    if current_user.room
      current_user.leave_the_room_system_comment
      current_user.leave_room
    end
    redirect_to rooms_path
  end

  def users
    @users = @room.users
  end

  def ban_user
    ban_or_drive_out_user(true)
  end

  def drive_out_user
    ban_or_drive_out_user(false)
  end

  def owner_transfer
    user_id = params[:user_id]
    to_user = User.find(user_id)
    if current_user.room_owner?
      current_user.room.owner_transfer(to_user)
    end
    redirect_to room_path(current_user.room)
  rescue => _e
    redirect_to room_path(current_user.room)
  end

  private

  def id
    params[:room_id] || params[:id]
  end

  def set_room_id_to_current_user
    return if current_user.room.present?
    current_user.into_the_room(@room)
    current_user.into_the_room_system_comment
  end

  def set_room
    @room = Room::ForCreate.new(controller_params)
    @room.user = current_user
  end

  def find_room
    @room = Room::ForUpdate.enabled.find(id)
    @room.assign_attributes(controller_params)
  rescue => _e
    redirect_to rooms_path
  end

  def controller_params
    params.fetch(:room, {}).permit(:name, :num)
  end

  def check_current_room
    return if current_user.room_id == @room.id
    redirect_to rooms_path
  end

  def check_room_max
    return if current_user.room_id == @room.id
    return unless @room.max?
    redirect_to rooms_path, notice: '満室です。'
  end

  def check_room_owner
    return if current_user.room_owner?
    redirect_to room_path(current_user.room), notice: '管理者権限がありません'
  end

  def check_exists_username
    return unless @room.exists_username?(current_user)
    redirect_to rooms_path, notice: '同じ部屋で同じ名前は利用できません'
  end

  def ban_or_drive_out_user(force_ban = false)
    user_id = params[:user_id]
    user = User.find(user_id)
    if force_ban
      user.ban!
    else
      user.drive_out!
    end
    redirect_to room_path(current_user.room)
  rescue => _e
    redirect_to room_path(current_user.room)
  end
end
