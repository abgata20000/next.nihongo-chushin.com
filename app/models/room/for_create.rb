class Room < ApplicationRecord
  class ForCreate < ActiveType::Record[Room]

    after_create :set_room_to_user
    after_create :echo_system_message_with_create
    after_create :set_cleanup_job


    private

    def set_room_to_user
      user.into_the_room(self)
    end

    def echo_system_message_with_create
      user.create_the_room_system_comment
    end

    def set_cleanup_job
      # 切断処理をキューに設定
      RoomCleanupJob.set(wait: connection_disconnected_time).perform_later(id)
    end
  end
end
