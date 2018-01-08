class UserBroadcast < ActiveType::Object
  attribute :user
  attribute :is_broadcast_to_chat, :boolean
  attribute :is_broadcast_to_room, :boolean
  attribute :is_broadcast_to_user, :boolean

  default_value_for :is_broadcast_to_chat, false
  default_value_for :is_broadcast_to_room, true
  default_value_for :is_broadcast_to_user, true

  def initialize(user: user)
    super
  end

  def broadcast
    ActionCable.server.broadcast room_label, broadcast_params
  end

  private

  def room_id
    user.room_id
  end

  def room_label
    "room:#{room_id}"
  end

  def broadcast_params
    {
        is_chat: is_broadcast_to_chat,
        is_room: is_broadcast_to_room,
        is_user: is_broadcast_to_user
    }
  end

end
