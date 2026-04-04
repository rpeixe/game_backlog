require 'rails_helper'

RSpec.describe CheapSharkClient do
  it "returns games from API" do
    stub_request(:get, "https://www.cheapshark.com/api/1.0/games")
      .with(query: { title: "test" })
      .to_return(
        status: 200,
        body: [
          {
            gameID: "1",
            external: "Test Game",
            thumb: nil,
            cheapest: "9.99"
          }
        ].to_json,
        headers: { "Content-Type" => "application/json" }
      )

    results = CheapSharkClient.search("test")

    expect(results.first.name).to eq("Test Game")
  end

  it "returns empty array on API failure" do
    stub_request(:get, "https://www.cheapshark.com/api/1.0/games")
      .with(query: { title: "test" })
      .to_return(status: 500)

    results = CheapSharkClient.search("test")

    expect(results).to eq([])
  end
end
