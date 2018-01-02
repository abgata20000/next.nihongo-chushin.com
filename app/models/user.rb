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
  DEFAULT_ICON = 'default'
  DEFAULT_COLOR = 'black'
  DEFAULT_SOUND = 'default'
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

  validates :token, allow_nil: true, uniqueness: true
  validates :name, allow_nil: true, uniqueness: true
  validates :icon, presence: true
  validates :color, presence: true
  validates :sound, presence: true
  validates :language, presence: true
  validates :role, presence: true

  after_initialize :generate_token

  scope :into_the_room_at_asc, -> { order(into_the_room_at: :asc) }

  def logout
    update(room_id: nil, nickname: nil, color: DEFAULT_COLOR, icon: DEFAULT_ICON, sound: DEFAULT_SOUND, into_the_room_at: nil, last_commented_at: nil, last_connected_at: nil)
  end

  def now
    Time.zone.now
  end

  def into_the_room_system_comment
    message = "#{nickname}さんが入室しました。"
    echo_system_comment(message)
  end

  def create_the_room_system_comment
    message = "#{nickname}さんが部屋を作成しました。"
    echo_system_comment(message)
  end

  def leave_the_room_system_comment
    message = "#{nickname}さんが退室しました。"
    echo_system_comment(message)
  end

  def echo_system_comment(message)
    pp '*'*100
    pp message
    Chat::SystemMessage.create!(room: room, comment: message)
  end

  def into_the_room(room)
    update(room: room, into_the_room_at: now, last_commented_at: now, last_connected_at: now)
  end

  def commented
    update(last_commented_at: now, last_connected_at: now)
  end

  def connected
    update(last_connected_at: Time.zone.now)
  end

  def leave_room
    update(room: nil, into_the_room_at: nil, last_commented_at: nil, last_connected_at: nil)
  end

  def room_owner?
    room && room.user_id == id
  end

  def connection_expired?
    return true if room.blank?
    last_connected_at + room.connection_disconnected_time.second < Time.zone.now
  end

  def comment_expired?
    return true if room.blank?
    last_commented_at + room.comment_disconnected_time.second < Time.zone.now
  end

  private

  def generate_token
    self.token = SecureRandom.hex(32) if token.blank?
  end

end
