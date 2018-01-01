module NihongoChushin
  class CommentCable
    class << self
      def generate_room_label(room_id)
        return 'comment' if room_id.blank?
        "comment:#{room_id}"
      end

      def generate_user_label(user_id)
        return 'user' if user_id.blank?
        "user:#{user_id}"
      end


      def echo(room_id, chat)
        room_label = generate_room_label(room_id)
        ActionCable.server.broadcast room_label, comment: render_comment(chat)
      end

      def users(room)
        room_label = generate_room_label(room.id)
        ActionCable.server.broadcast room_label, users: render_users(room)
      end

      def room(room)
        room_label = generate_room_label(room.id)
        ActionCable.server.broadcast room_label, room: render_room(room)
      end

      def disconnect_user(user_id)
        user_label = generate_user_label(user_id)
        ActionCable.server.broadcast user_label, is_disconnect: true
      end

      private

      def render_comment(chat)
        ApplicationController.renderer.render(partial: 'chats/comment', locals: {chat: chat})
      end

      def render_users(room)
        ApplicationController.renderer.render(partial: 'chats/users', locals: {room: room})
      end

      def render_room(room)
        ApplicationController.renderer.render(partial: 'chats/room', locals: {room: room})
      end

    end
  end
end
