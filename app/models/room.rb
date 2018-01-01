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
  belongs_to :user
  has_many :users
  has_many :chats

  default_value_for :connection_disconnected_time, 60
  default_value_for :comment_disconnected_time, 600
  default_value_for :num, 5
  default_value_for :public, false
  default_value_for :knock, false

  validates :name, presence: true, length: { in: 1..20 }
  validates :num, presence: true, numericality: {greater_than_or_equal_to: 2, less_than_or_equal_to: 10}
  validates :connection_disconnected_time, presence: true, numericality: {greater_than_or_equal_to: 10, less_than_or_equal_to: 3600}
  validates :comment_disconnected_time, presence: true, numericality: {greater_than_or_equal_to: 10, less_than_or_equal_to: 3600}

  def max?
    num <= users.size
  end

  def first_user
    users.into_the_room_at_asc.first
  end

  def move_owner
    update_attributes(user: first_user)
  end
end
