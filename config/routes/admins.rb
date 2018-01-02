namespace :admins do
  root to: 'static_pages#top'
  resource :sessions, only: %w(new create destroy)
end
