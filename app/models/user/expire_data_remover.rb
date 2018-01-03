class User < ApplicationRecord
  class ExpireDataRemover < ActiveType::Record[User]
    include ExpireDataRemovable
  end
end
