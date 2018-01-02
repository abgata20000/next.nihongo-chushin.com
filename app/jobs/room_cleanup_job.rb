class RoomCleanupJob < ApplicationJob
  queue_as :cleanup

  def perform(room_id)
    Room::ForCleanup.run(room_id)
  end
end
