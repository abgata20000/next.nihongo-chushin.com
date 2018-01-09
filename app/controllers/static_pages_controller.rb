class StaticPagesController < ApplicationController
  before_action :set_top_variables, only: %w(top)
  SHOW_COMMENT_NUM = 100
  def top

  end


  private

  def set_top_variables
    @room = Room.enabled.where(is_fixed: true, is_public: true).first
    @chats = @room.chats.enabled.where(system_message: false).order(updated_at: :desc).limit(SHOW_COMMENT_NUM) if @room
    redirect_to rooms_path if @chats.blank?
  end
end
