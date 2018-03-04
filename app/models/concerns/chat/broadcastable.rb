class Chat < ApplicationRecord
  module Broadcastable
    extend ActiveSupport::Concern

    included do
      attribute :is_broadcast_to_chat, :boolean
      attribute :is_broadcast_to_room, :boolean
      attribute :is_broadcast_to_user, :boolean

      default_value_for :is_broadcast_to_chat, true
      default_value_for :is_broadcast_to_room, false
      default_value_for :is_broadcast_to_user, false

      after_save :broadcast
    end

    private

    def room_label
      "room:#{room_id}"
    end

    def user_label
      "user:#{user_id}"
    end

    def broadcast
      ActionCable.server.broadcast room_label, broadcast_params
    end

    def broadcast_params
      {
          chat_id: id,
          is_chat: is_broadcast_to_chat,
          is_room: is_broadcast_to_room,
          is_user: is_broadcast_to_user
      }
    end
  end
end
