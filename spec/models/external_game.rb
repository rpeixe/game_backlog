require 'rails_helper'

RSpec.describe ExternalGame do
  it "maps API data correctly" do
    id = "1"
    name = "Zelda"
    image = "img.jpg"
    price = "5.99"

    data = {
      "gameID" => id,
      "external" => name,
      "thumb" => image,
      "cheapest" => price
    }

    game = ExternalGame.new(data)

    expect(game.external_id).to eq(id)
    expect(game.name).to eq(name)
    expect(game.image_url).to eq(image)
    expect(game.cheapest_price).to eq(price)
  end
end
