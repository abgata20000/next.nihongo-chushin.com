Sidekiq.configure_server do |config|
  if ENV['REDIS_URL'].present?
    config.redis = {url: ENV['REDIS_URL']}
  else
    config.redis = {url: 'redis://127.0.0.1:6379'}
  end
end

Sidekiq.configure_client do |config|
  if ENV['REDIS_URL'].present?
    config.redis = {url: ENV['REDIS_URL']}
  else
    config.redis = {url: 'redis://127.0.0.1:6379'}
  end
end
