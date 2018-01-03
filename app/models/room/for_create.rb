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
