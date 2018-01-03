class ExpireDataRemoveService
  class << self
    def run
      User::ExpireDataRemover.run
      Room::ExpireDataRemover.run
      Chat::ExpireDataRemover.run
    end
  end
end
