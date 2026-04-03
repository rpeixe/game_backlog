require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET /search" do
    it "returns http success" do
      get "/games/search"
      expect(response).to have_http_status(:success)
    end
  end

end
