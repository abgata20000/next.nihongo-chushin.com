class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_BASIC_USER'] && password == ENV['SIDEKIQ_BASIC_PASSWORD']
  end
  mount Sidekiq::Web => '/my-sidekiq'

  root to: 'static_pages#top'
  resource :my_pages, only: %w(show update)
  resource :room, only: %w() do
    delete 'leave'
  end
  resources :rooms, only: %w(new create show index edit update) do
    get 'join'
    get 'users'
    put 'owner_transfer'
    delete 'ban_user'
    delete 'drive_out_user'
  end
  resources :chats, only: %w(create)
  resource :sessions, only: %w(create destroy)
  get 'signin', to: 'sessions#new'
  get 'sessions', to: 'sessions#new'
  #
  draw :apis
  draw :admins
end

# == Route Map
#
#              Prefix Verb   URI Pattern                        Controller#Action
#         sidekiq_web        /my-sidekiq                        Sidekiq::Web
#                root GET    /                                  static_pages#top
#            my_pages GET    /my_pages(.:format)                my_pages#show
#                     PATCH  /my_pages(.:format)                my_pages#update
#                     PUT    /my_pages(.:format)                my_pages#update
#          leave_room DELETE /room/leave(.:format)              rooms#leave
#           room_join GET    /rooms/:room_id/join(.:format)     rooms#join
#          room_users GET    /rooms/:room_id/users(.:format)    rooms#users
#       room_ban_user DELETE /rooms/:room_id/ban_user(.:format) rooms#ban_user
#               rooms GET    /rooms(.:format)                   rooms#index
#                     POST   /rooms(.:format)                   rooms#create
#            new_room GET    /rooms/new(.:format)               rooms#new
#           edit_room GET    /rooms/:id/edit(.:format)          rooms#edit
#                room GET    /rooms/:id(.:format)               rooms#show
#                     PATCH  /rooms/:id(.:format)               rooms#update
#                     PUT    /rooms/:id(.:format)               rooms#update
#               chats POST   /chats(.:format)                   chats#create
#            sessions DELETE /sessions(.:format)                sessions#destroy
#                     POST   /sessions(.:format)                sessions#create
#              signin GET    /signin(.:format)                  sessions#new
#                     GET    /sessions(.:format)                sessions#new
#          apis_chats GET    /apis/chats(.:format)              apis/chats#show
#                     POST   /apis/chats(.:format)              apis/chats#create
#    users_apis_rooms GET    /apis/rooms/users(.:format)        apis/rooms#users
#          apis_rooms GET    /apis/rooms(.:format)              apis/rooms#show
#         admins_root GET    /admins(.:format)                  admins/static_pages#top
# new_admins_sessions GET    /admins/sessions/new(.:format)     admins/sessions#new
#     admins_sessions DELETE /admins/sessions(.:format)         admins/sessions#destroy
#                     POST   /admins/sessions(.:format)         admins/sessions#create
# 
