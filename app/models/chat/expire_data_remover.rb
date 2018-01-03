class Chat < ApplicationRecord
  class ExpireDataRemover < ActiveType::Record[Chat]
    include ExpireDataRemovable
    class << self
      private


    end
  end
end
