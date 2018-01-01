class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  get 'session/create'

  get 'session/destroy'

  get 'hoge/index'

  root to: "static_pages#top"
  draw :users
end
