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
  belongs_to :user
  belongs_to :room

  default_value_for :system_message, true

  validates :comment, presence: true, length: { maximum: 500 }

  before_validation :set_user_attributes

  private

  def set_user_attributes
    if user
      self.nickname = user.nickname
      self.color = user.color
      self.icon = user.icon
      self.system_message = false
    end
  end

end
