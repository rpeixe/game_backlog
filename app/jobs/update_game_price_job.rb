class UpdateGamePriceJob < ApplicationJob
  queue_as :default

  def perform(game_id)
    game = Game.find(game_id)

    data = CheapSharkClient.find_game(game.external_id)

    return unless data && data["deals"].present?

    cheapest_deal = data["deals"].min_by { |deal| deal["price"].to_f }

    game.update(
      cheapest_price: cheapest_deal["price"],
      store_id: cheapest_deal["storeID"],
      deal_id: cheapest_deal["dealID"],
      last_price_update: Time.current
    )

    stores = CheapSharkClient.stores_by_id
    store = stores[cheapest_deal["storeID"]]

    ActionCable.server.broadcast("prices", {
      game_id: game.id,
      price: cheapest_deal["price"],
      store_name: store&.dig("storeName"),
      store_logo: store&.dig("images", "logo"),
      deal_id: cheapest_deal["dealID"]
    })
  rescue StandardError => e
    Rails.logger.error("Price update failed: #{e.message}")
  end
end
