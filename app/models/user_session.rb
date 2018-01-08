class UserSession < ActiveType::Object
  attribute :user
  attribute :nickname, :string
  attribute :email, :string
  attribute :icon, :string
  attribute :color, :string
  attribute :sound, :string

  default_value_for :color, 'black'
  default_value_for :icon, 'default'
  default_value_for :sound, 'beep_1'

  validates :user, presence: true
  validates :nickname, presence: true, length: {in: 2..10}
  validates :color, presence: true
  validates :icon, presence: true
  validates :sound, presence: true

  after_save :update_user

  private

  def update_user
    user.update!(
        nickname: nickname,
        color: color,
        icon: icon,
        sound: sound,
        last_logged_in_at: Time.zone.now
    )
  end
end
