require 'rails_helper'

RSpec.describe UpdateGamePriceJob, type: :job do
  it "updates game with cheapest price" do
    stub_request(:get, /cheapshark/)
      .to_return(
        status: 200,
        body: {
          deals: [
            { price: "10.00" },
            { price: "5.99" }
          ]
        }.to_json,
        headers: { "Content-Type" => "application/json" }
      )

    game = Game.create!(external_id: "1", name: "Test")

    UpdateGamePriceJob.perform_now(game.id)

    expect(game.reload.cheapest_price).to eq(5.99)
  end
end
