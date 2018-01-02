module ChatDecorator
  include BaseDecorator

  def comment_by_system
    "----- #{comment}"
  end

end