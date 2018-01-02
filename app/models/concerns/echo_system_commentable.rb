module EchoSystemCommentable
  extend ActiveSupport::Concern


  private

  def echo_system_comment(message, is_broadcast_to_chat: true, is_broadcast_to_room: false, is_broadcast_to_user: false)
    Chat::SystemMessage.create!(room_id: room_id, comment: message,
                                is_broadcast_to_chat: is_broadcast_to_chat,
                                is_broadcast_to_room: is_broadcast_to_room,
                                is_broadcast_to_user: is_broadcast_to_user
    )
  end
end
