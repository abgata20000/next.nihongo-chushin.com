# == Schema Information
#
# Table name: rooms
#
#  id                           :integer          not null, primary key
#  user_id                      :integer          not null
#  name                         :string           not null
#  password                     :string
#  language                     :string           default("ja"), not null
#  can_knock                    :boolean          default(FALSE), not null
#  is_public                    :boolean          default(FALSE), not null
#  is_visible                   :boolean          default(TRUE), not null
#  is_fixed                     :boolean          default(FALSE), not null
#  connection_disconnected_time :integer          default(60), not null
#  comment_disconnected_time    :integer          default(600), not null
#  num                          :integer          default(5), not null
#  show_comment_count           :integer          default(100), not null
#  memo                         :text
#  deleted_at                   :datetime
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_rooms_on_created_at  (created_at)
#  index_rooms_on_deleted_at  (deleted_at)
#  index_rooms_on_language    (language)
#  index_rooms_on_updated_at  (updated_at)
#  index_rooms_on_user_id     (user_id)
#

class Room < ApplicationRecord
  class ForCleanup < ActiveType::Record[Room]

    class << self
      def run(room_id)
        room = enabled.find_by(id: room_id)
        return unless room
        room.cleanup
      end
    end

    def cleanup
      # 接続切れチェック
      expired_users.each do |user|
        # TODO: 5分で接続切れになってしまっているので一旦止めておく
        break
        user.disconnected_the_room_system_comment
        user.leave_room
        user.broadcast_disconnect
      end
      set_next_job
    end

    private

    def expired_users
      users.select do |user|
        user.room_expired?
      end
    end

    # 部屋がまだあれば次回の切断処理をキューに設定
    def set_next_job
      return unless enabled?
      RoomCleanupJob.set(wait: connection_disconnected_time).perform_later(id)
    end
  end
end
