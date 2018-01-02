module RoomDecorator
  include BaseDecorator

  def current_room_num
    "(#{users.size}/#{num})"
  end
end