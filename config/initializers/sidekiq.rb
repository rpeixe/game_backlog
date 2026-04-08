# Be sure to restart your server when you modify this file.

require "sidekiq"

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_SIDEKIQ_URL"] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_SIDEKIQ_URL"] }
end
