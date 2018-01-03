class Room < ApplicationRecord
  class ExpireDataRemover < ActiveType::Record[Room]
    include ExpireDataRemovable
    class << self
      private

      def target
        disabled.where('updated_at < ?' , target_date)
      end
    end
  end
end
