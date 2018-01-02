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
