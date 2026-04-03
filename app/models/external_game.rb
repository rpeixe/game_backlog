class ExternalGame
  attr_reader :external_id, :name, :image_url, :cheapest_price

  def initialize(data)
    @external_id = data["gameID"]
    @name = data["external"]
    @image_url = data["thumb"]
    @cheapest_price = data["cheapest"]
  end
end
