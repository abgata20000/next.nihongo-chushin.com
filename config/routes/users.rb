namespace :users do
  resource :user, only: %w(edit update)
  root to: "static_pages#top"
end
