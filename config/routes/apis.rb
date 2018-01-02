namespace :apis do
  resource :chats, only: %w(show create)
  resource :rooms, only: %w(show) do
    get 'users'
  end
end
