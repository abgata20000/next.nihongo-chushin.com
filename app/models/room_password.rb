class RoomPassword < ActiveType::Object
  attribute :room
  attribute :user
  attribute :password, :string


  validates :room, presence: true
  validates :user, presence: true
  validates :password, presence: true


  before_validation :check_password

  private

  def check_password
    return if room.password.blank?
    return if password == room.password
    errors.add(:password, :password_is_incorrect)
  end
end
