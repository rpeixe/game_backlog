class CleanupGamesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    games = Game.stale_unused

    Rails.logger.info("Cleaning up #{games.count} unused games")

    games.find_each do |game|
      game.destroy
    end
  end
end
