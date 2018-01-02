# == Schema Information
#
# Table name: premium_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  email      :string
#  password   :string
#  memo       :text
#  ip         :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_premium_users_on_email    (email) UNIQUE
#  index_premium_users_on_name     (name) UNIQUE
#  index_premium_users_on_user_id  (user_id)
#

class PremiumUser < ApplicationRecord
  belongs_to :user

  validates :email, allow_nil: true, email: {not_duplication: true}
  validates :name, allow_nil: true, uniqueness: true
end
