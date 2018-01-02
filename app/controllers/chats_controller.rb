class ChatsController < ApplicationController
  before_action :logged_in_check
  before_action :check_room
  before_action :set_chat

  def create
    @chat.save
    redirect_to room_path(current_user.room)
  end

  private

  def set_chat
    @chat = Chat.new(controller_params)
    @chat.user = current_user
    @chat.room = current_user.room
  end

  def controller_params
    params.fetch(:chat, {}).permit(:comment)
  end

  def check_room
    return if current_user.room.present?
    redirect_to room_path(current_user.room)
  end
end
