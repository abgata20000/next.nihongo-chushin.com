# == Schema Information
#
# Table name: chats
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  room_id        :integer          not null
#  nickname       :string
#  color          :string
#  icon           :string
#  comment        :text
#  system_message :boolean          default(TRUE), not null
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_chats_on_created_at  (created_at)
#  index_chats_on_deleted_at  (deleted_at)
#  index_chats_on_room_id     (room_id)
#  index_chats_on_updated_at  (updated_at)
#  index_chats_on_user_id     (user_id)
#

class Chat < ApplicationRecord
  class ForPost < ActiveType::Record[Chat]
    include Broadcastable

    after_save :user_commented

    class << self
      def chats_with_render_views(user, last_chat_id = 0)
        chats = includes(:user)
                    .where(room: user.room)
                    .where('chats.id > ?', last_chat_id)
                    .limit(user.room.show_comment_count)
                    .order(updated_at: :asc)
        chats.map do |chat|
          chat.show_attributes
        end
      end
    end

    #
    def show_attributes
      {
          chat: self,
          view: render_comment
      }
    end

    def show_errors
      {errors: errors.full_messages}
    end

    private

    def user_commented
      user.commented
    end

    def render_comment
      ApplicationController.renderer.render(partial: 'comment', locals: {chat: self})
    end
  end
end
