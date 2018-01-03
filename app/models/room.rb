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
  include EchoSystemCommentable

  LIMIT_NUM = 100
  belongs_to :user
  has_many :users
  has_many :chats

  default_value_for :connection_disconnected_time, 300
  default_value_for :comment_disconnected_time, 600
  default_value_for :num, 5
  default_value_for :language, 'ja'
  default_value_for :is_public, false
  default_value_for :is_visible, true
  default_value_for :can_knock, false
  default_value_for :is_fixed, false
  default_value_for :show_comment_count, 100

  validates :name, presence: true, length: {in: 2..20}
  validates :num, presence: true, numericality: {greater_than_or_equal_to: 2, less_than_or_equal_to: 10}
  validates :connection_disconnected_time, presence: true, numericality: {greater_than_or_equal_to: 10, less_than_or_equal_to: 3600}
  validates :comment_disconnected_time, presence: true, numericality: {greater_than_or_equal_to: 10, less_than_or_equal_to: 3600}

  scope :enabled, -> { where(deleted_at: nil) }
  scope :newest, -> { order(updated_at: :desc) }

  class << self
    def active_rooms
      includes(:users).enabled.newest.limit(LIMIT_NUM)
    end
  end

  def close_with_leave_if_empty_users
    return if is_fixed
    return if users.count > 0
    close
  end

  def title_with_nums
    "(#{users.count}/#{num})#{name}"
  end

  def show_attributes
    tmp = attributes
    tmp.delete('password')
    tmp[:room_name] = title_with_nums
    tmp
  end

  def close
    update(deleted_at: now)
  end

  def max?
    num <= users.size
  end

  def enabled?
    deleted_at.nil?
  end

  def first_user
    users.into_the_room_at_asc.first
  end

  def move_owner_first_user
    return if user && user.room_id == id
    update(user: first_user)
    move_owner_system_comment
  end

  def move_owner_system_comment
    return unless user
    message = "#{user.nickname}さんに管理権限が移動しました。"
    echo_system_comment(message, is_broadcast_to_user: true, is_broadcast_to_room: true)
  end

  def exists_username?(my_user)
    nicknames = users.pluck(:nickname).map do |name|
      name.strip.downcase
    end
    nicknames.include?(my_user.nickname.downcase)
  end

  def exists_color?(my_user)
    colors = users.pluck(:color)
    colors.include?(my_user.color)
  end

  private

  def room_id
    id
  end
end
