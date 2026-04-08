# Be sure to restart your server when you modify this file.

require "sidekiq"
require "sidekiq/cron/job"

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_SIDEKIQ_URL"] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_SIDEKIQ_URL"] }
end

Sidekiq::Cron::Job.create(
  name: "Cleanup unused games - daily",
  cron: "0 3 * * *", # every day at 3am
  class: "CleanupGamesJob"
)
