class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "chat"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def set_connected(_data)
    current_user.connected
    current_user.reload
    stop_all_streams
    stream_from "chats"
    stream_from "user:#{current_user.id}"
    stream_from "room:#{current_user.room_id}" if current_user.room
  end
end
