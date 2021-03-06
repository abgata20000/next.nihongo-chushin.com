# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  room_id           :integer
#  name              :string
#  token             :string
#  role              :integer          default("user"), not null
#  color             :string
#  icon              :string
#  sound             :string
#  is_mobile         :boolean          default(FALSE)
#  enabled           :boolean          default(TRUE), not null
#  into_the_room_at  :datetime
#  last_commented_at :datetime
#  last_connected_at :datetime
#  last_logged_in_at :datetime
#  memo              :text
#  ip                :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  is_connected      :boolean          default(FALSE)
#  language          :string           default("ja"), not null
#  nickname          :string
#
# Indexes
#
#  index_users_on_into_the_room_at   (into_the_room_at)
#  index_users_on_language           (language)
#  index_users_on_last_commented_at  (last_commented_at)
#  index_users_on_last_connected_at  (last_connected_at)
#  index_users_on_last_logged_in_at  (last_logged_in_at)
#  index_users_on_name               (name) UNIQUE
#  index_users_on_room_id            (room_id)
#  index_users_on_token              (token) UNIQUE
#  index_users_on_updated_at         (updated_at)
#

class User < ApplicationRecord
  include EchoSystemCommentable
  DEFAULT_ICON = 'default'
  DEFAULT_COLOR = 'black'
  DEFAULT_SOUND = 'silent'
  DEFAULT_LANG = 'ja'

  belongs_to :room, optional: true
  has_many :chats
  has_one :premium_user

  enumerize :role, in: {
      guest: 0,
      user: 1,
      premium_user: 2,
      manager: 9,
      admin: 10,
      ban_user: 99,
  }, scope: true

  enumerize :color, in: Color.to_array, scope: true
  enumerize :icon, in: Icon.to_array, scope: true
  enumerize :sound, in: Sound.to_array, scope: true
  enumerize :language, in: Language.to_array, scope: true

  default_value_for :role, :guest
  default_value_for :color, DEFAULT_COLOR
  default_value_for :icon, DEFAULT_ICON
  default_value_for :sound, DEFAULT_SOUND
  default_value_for :language, DEFAULT_LANG
  default_value_for :enabled, true
  default_value_for :is_mobile, false
  default_value_for :into_the_room_at, nil
  default_value_for :last_commented_at, nil
  default_value_for :last_connected_at, nil
  default_value_for :last_logged_in_at do
    Time.zone.now
  end

  # validates :token, allow_nil: true, uniqueness: true
  validates :name, allow_nil: true, uniqueness: true
  validates :icon, presence: true
  validates :color, presence: true
  validates :sound, presence: true
  validates :language, presence: true
  validates :role, presence: true

  validate :check_already_used_color

  after_initialize :generate_token
  before_validation :strip_name
  before_validation :strip_nickname

  scope :into_the_room_at_asc, -> { order(into_the_room_at: :asc) }

  def logout
    update(room_id: nil, nickname: nil, color: DEFAULT_COLOR, icon: DEFAULT_ICON, sound: DEFAULT_SOUND, into_the_room_at: nil, last_commented_at: nil, last_connected_at: nil)
  end

  def into_the_room_system_comment
    message = "#{nickname}さんが入室しました。"
    echo_system_comment(message, is_broadcast_to_user: true, is_broadcast_to_room: true)
  end

  def create_the_room_system_comment
    message = "#{nickname}さんが部屋を作成しました。"
    echo_system_comment(message)
  end

  def leave_the_room_system_comment
    message = "#{nickname}さんが退室しました。"
    echo_system_comment(message, is_broadcast_to_user: true, is_broadcast_to_room: true)
  end

  def drive_out_the_room_system_comment
    message = "#{nickname}さんが退室させられました。"
    echo_system_comment(message, is_broadcast_to_user: true, is_broadcast_to_room: true)
  end

  def ban_the_room_system_comment
    message = "#{nickname}さんが入室禁止にされました。"
    echo_system_comment(message, is_broadcast_to_user: true, is_broadcast_to_room: true)
  end

  def disconnected_the_room_system_comment
    message = "#{nickname}さんの接続が切断されました。"
    echo_system_comment(message, is_broadcast_to_user: true, is_broadcast_to_room: true)
  end

  def into_the_room(room)
    update(room: room, color: room.random_color, into_the_room_at: now, last_commented_at: now, last_connected_at: now)
  end

  def commented
    update(last_commented_at: now, last_connected_at: now)
  end

  def connected
    update(last_connected_at: now)
  end

  def ban!
    ban_the_room_system_comment
    add_banned_room
    leave_room
    broadcast_disconnect
  end

  def drive_out!
    drive_out_the_room_system_comment
    leave_room
    broadcast_disconnect
  end

  def leave_room
    prev_room = room
    update(room: nil, into_the_room_at: nil, last_commented_at: nil, last_connected_at: nil)
    prev_room.close_with_leave_if_empty_users
    prev_room.move_owner_first_user
  end

  def room_owner?
    room && room.user_id == id
  end

  def room_expired?
    # TODO: connection_expiredがうまくとれていない？
    # connection_expired? || comment_expired?
    comment_expired?
  end

  def connection_expired?
    return true if room.blank?
    last_connected_at + room.connection_disconnected_time.second < now
  end

  def comment_expired?
    return true if room.blank?
    last_commented_at + room.comment_disconnected_time.second < now
  end

  def render_view
    ApplicationController.renderer.render(partial: 'user', locals: {user: self})
  end

  def show_my_page_attributes
    {
        id: id,
        name: name,
        color: color,
        sound: sound,
        icon: icon,
        is_mobile: is_mobile
    }
  end

  def enabled_colors
    return Color.all unless room
    colors = room.enabled_colors + [color]
    Color.where(name: colors)
  end

  def broadcast_to_room_users
    user_broadcast = UserBroadcast.new(user: self)
    user_broadcast.broadcast
  end

  def broadcast_disconnect
    ActionCable.server.broadcast user_label, {is_disconnect: true}
  end

  private

  def check_already_used_color
    return true unless color_changed?
    return true if color.nil?
    return true if room.nil?
    if room.already_used_color?(self)
      errors.add(:color, :already_used_color)
      self.color = color_was
      return false
    end
    true
  end

  def generate_token
    self.token = SecureRandom.hex(32) if token.blank?
  end

  def user_id
    id
  end

  def user_label
    "user:#{user_id}"
  end

  def strip_name
    return if name.blank?
    self.name = name.strip
  end

  def strip_nickname
    return if nickname.blank?
    self.nickname = nickname.strip
  end

  # TODO: 未実装
  def add_banned_room

  end

end
