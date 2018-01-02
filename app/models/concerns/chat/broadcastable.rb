class Chat < ApplicationRecord
  module Broadcastable
    extend ActiveSupport::Concern

    included do
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
      ActionCable.server.broadcast room_label, {chat_id: id}
    end
  end
end
