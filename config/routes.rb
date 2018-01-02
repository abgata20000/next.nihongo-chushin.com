class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  root to: 'static_pages#top'
  resource :my_pages, only: %w(show)
  resource :room, only: %w() do
    get 'leave'
  end
  resources :rooms, only: %w(new create show index edit update destroy)
  resources :chats, only: %w(create)
  resource :sessions, only: %w(create destroy)
  get 'signin', to: 'sessions#new'
  #
  draw :apis
  draw :admins
end
