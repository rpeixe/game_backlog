class CheapSharkClient
  include HTTParty
  base_uri "https://www.cheapshark.com/api/1.0"

  def self.search(query)
    response = get("/games", query: { title: query })

    handle_response(response)
  end

  def self.handle_response(response)
    return [] unless response.success?

    response.parsed_response.map do |game|
      ExternalGame.new(game)
    end
  rescue StandardError => e
    Rails.logger.error("CheapShark API failed: #{e.message}")
    []
  end
end
