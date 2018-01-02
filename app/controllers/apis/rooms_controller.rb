module Apis
  class RoomsController < ::Apis::ApplicationController
    def show
      @room = current_user.room
      render json: @room.show_attributes
    end

    def users
      @users = current_user.room.users.into_the_room_at_asc.map do |user|
        user.render_view
      end
      render json: @users
    end
  end
end
