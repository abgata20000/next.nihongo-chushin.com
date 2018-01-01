class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  root to: "static_pages#top"
  get "join" => "registration_emails#new"
  post "join" => "registration_emails#create"
  get "join/set/" => "registrations#new", as: :join_set
  get "faq" => "static_pages#faq", as: "faq"
  get "signin" => "sessions#new"
  resource :session, only: %w(new create destroy)
  resource :registration, only: %w(new create)

  draw :users
end
