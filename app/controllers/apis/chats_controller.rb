module Apis
  class ChatsController < ::Apis::ApplicationController
    def show
      current_user.connected
      @chats = Chat::ForPost.chats_with_render_views(current_user, last_chat_id)
      render json: @chats
    end

    def create
      @chat = Chat::ForPost.new(controller_params)
      if @chat.save
        render json: @chat.show_attributes
      else
        render json: @chat.show_errors, status: 400
      end
    end

    private

    def last_chat_id
      params[:last_chat_id].to_i
    end

    def controller_params
      tmp = params.permit(:comment)
      tmp[:user] = current_user
      tmp
    end
  end
end
