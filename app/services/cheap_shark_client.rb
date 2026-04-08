class CheapSharkClient
  include HTTParty
  base_uri "https://www.cheapshark.com/api/1.0"

  def self.search(query)
    Rails.cache.fetch("cheapshark/search/#{query}", expires_in: 1.hour) do
      response = get("/games", query: { title: query })

      return [] unless response.success?

      response.parsed_response.map do |data|
        ExternalGame.new(data)
      end
    end
  rescue Timeout::Error
    Rails.logger.error("(Search) CheapShark timeout")
    []
  rescue SocketError
    Rails.logger.error("(Search) Network error when calling CheapShark")
    []
  rescue StandardError => e
    Rails.logger.error("(Search) Unexpected API error: #{e.message}")
    []
  end

  def self.find_game(external_id)
    Rails.cache.fetch("cheapshark/game/#{external_id}", expires_in: 6.hours) do
      response = get("/games", query: { id: external_id })

      return nil unless response.success?

      response.parsed_response
    end
  rescue Timeout::Error
    Rails.logger.error("(Lookup) CheapShark timeout")
    nil
  rescue SocketError
    Rails.logger.error("(Lookup) Network error when calling CheapShark")
    nil
  rescue StandardError => e
    Rails.logger.error("(Lookup) Unexpected API error: #{e.message}")
    nil
  end

  def self.stores
    Rails.cache.fetch("cheapshark/stores", expires_in: 7.days) do
      response = get("/stores")

      return [] unless response.success?

      response.parsed_response
    end
  rescue Timeout::Error
    Rails.logger.error("(Stores) CheapShark timeout")
    nil
  rescue SocketError
    Rails.logger.error("(Stores) Network error when calling CheapShark")
    nil
  rescue StandardError => e
    Rails.logger.error("(Stores) Unexpected API error: #{e.message}")
    nil
  end

  def self.stores_by_id
    stores.index_by { |store| store["storeID"] }
  end
end
