module UserDecorator
  include BaseDecorator

  def nickname_with_owner_mark
    if room_owner?
      "#{nickname}(★)"
    else
      nickname
    end
  end
end