require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET /search" do
    it "returns http success" do
      get "/games/search"

      expect(response).to have_http_status(:success)
    end

    it "displays games names" do
      fake_game = ExternalGame.new({
        "gameID" => "1",
        "external" => "Zelda",
        "thumb" => nil,
        "cheapest" => "10"
      })

      allow(CheapSharkClient).to receive(:search).and_return([ fake_game ])

      get "/games/search", params: { query: "zelda" }

      expect(response.body).to include("Zelda")
    end
  end
end
