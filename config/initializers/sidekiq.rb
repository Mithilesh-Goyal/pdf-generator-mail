Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis.example.com:7372/0' }
end
