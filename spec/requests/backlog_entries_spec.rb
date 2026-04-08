require 'rails_helper'

RSpec.describe "BacklogEntries", type: :request do
  fixtures :users, :backlog_entries

  let(:user) { users(:one) }

  before do
    sign_in_as user
  end

  describe "GET /index" do
    it "returns http success" do
      stub_request(:get, /cheapshark/)
        .to_return(
          status: 200,
          body: [ {} ].to_json,
          headers: { "Content-Type" => "application/json" }
        )

      get "/backlog_entries"

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /" do
    it "creates a backlog entry" do
      expect {
        post "/backlog_entries", params: {
          external_id: "test_1",
          name: "Test Game",
          image_url: nil
        }
      }.to change(Game, :count).by(1)
        .and change(BacklogEntry, :count).by(1)
    end

    it "does not create duplicate backlog entry" do
      external_id = "test_1"
      name = "Test Game"

      game = Game.create!(external_id: external_id, name: name)

      BacklogEntry.create!(user: user, game: game)

      expect {
        post "/backlog_entries", params: {
          external_id: external_id,
          name: name,
          image_url: nil
        }
      }.not_to change(BacklogEntry, :count)
    end
  end

  describe "PUT /:id" do
    it "updates status" do
      entry = backlog_entries(:one)

      patch "/backlog_entries/#{entry.id}", params: { status: "playing" }

      expect(entry.reload.status).to eq("playing")
    end

    it "does not update status from another user" do
      entry = backlog_entries(:three)

      patch "/backlog_entries/#{entry.id}", params: { status: "playing" }

      expect(entry.reload.status).not_to eq("playing")
    end
  end

  describe "DELETE /:id" do
    it "removes entry" do
      entry = backlog_entries(:one)

      expect {
        delete "/backlog_entries/#{entry.id}"
      }.to change(BacklogEntry, :count).by(-1)
    end

    it "doest not remove entry from another user" do
      entry = backlog_entries(:three)

      expect {
        delete "/backlog_entries/#{entry.id}"
      }.not_to change(BacklogEntry, :count)
    end
  end
end
