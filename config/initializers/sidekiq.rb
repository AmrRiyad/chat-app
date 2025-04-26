Sidekiq.configure_server do |config|
  config.redis = { url: "redis://redis:6379", size: 10, pool_name: "internal" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://redis:6379", size: 10, pool_name: "internal" }
end
