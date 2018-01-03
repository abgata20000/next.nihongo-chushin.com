class StaticPagesController < ApplicationController
  def top
    redirect_to rooms_path
  end
end
