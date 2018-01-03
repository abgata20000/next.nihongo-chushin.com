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
  class ExpireDataRemover < ActiveType::Record[User]
    include ExpireDataRemovable
  end
end
