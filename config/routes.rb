class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  # require 'sidetiq/web'
  mount Sidekiq::Web => '/my-sidekiq'

  root to: 'static_pages#top'
  resource :my_pages, only: %w(show update)
  resource :room, only: %w() do
    delete 'leave'
  end
  resources :rooms, only: %w(new create show index edit update) do
    get 'join'
    get 'users'
    delete 'ban_user'
  end
  resources :chats, only: %w(create)
  resource :sessions, only: %w(create destroy)
  get 'signin', to: 'sessions#new'
  get 'sessions', to: 'sessions#new'
  #
  draw :apis
  draw :admins
end
