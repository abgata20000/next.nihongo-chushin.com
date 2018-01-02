namespace :apis do
  resource :chats, only: %w(show create)
end
