class CheapSharkClient
  include HTTParty
  base_uri "https://www.cheapshark.com/api/1.0"

  def self.search(query)
    response = get("/games", query: { title: query })

    handle_response(response)
  rescue Timeout::Error
    Rails.logger.error("CheapShark timeout")
    []
  rescue SocketError
    Rails.logger.error("Network error when calling CheapShark")
    []
  rescue StandardError => e
    Rails.logger.error("Unexpected API error: #{e.message}")
    []
  end

  def self.handle_response(response)
    return [] unless response.success?

    response.parsed_response.map do |game|
      ExternalGame.new(game)
    end
  end

  def self.find_game(external_id)
    response = get("/games", query: { id: external_id })

    return nil unless response.success?

    response.parsed_response
  rescue StandardError => e
    Rails.logger.error("CheapShark lookup failed: #{e.message}")
    nil
  end
end
