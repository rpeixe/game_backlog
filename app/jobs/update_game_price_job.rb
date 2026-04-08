class UpdateGamePriceJob < ApplicationJob
  queue_as :default

  def perform(game_id)
    game = Game.find(game_id)

    data = CheapSharkClient.find_game(game.external_id)

    return unless data && data["deals"].present?

    cheapest_price = data["deals"]
      .map { |deal| deal["price"].to_f }
      .min

    game.update(
      cheapest_price: cheapest_price,
      last_price_update: Time.current
    )

    ActionCable.server.broadcast("prices", {
      game_id: game.id,
      price: cheapest_price
    })
  rescue StandardError => e
    Rails.logger.error("Price update failed: #{e.message}")
  end
end
