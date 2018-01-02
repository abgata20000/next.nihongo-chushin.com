class Room < ApplicationRecord
  class ForUpdate < ActiveType::Record[Room]

    after_update :update_system_comment


    private

    def update_system_comment
      message = "部屋の情報が更新されました。"
      echo_system_comment(message, is_broadcast_to_room: true)
    end
  end
end
