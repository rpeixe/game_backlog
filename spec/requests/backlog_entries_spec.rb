require 'rails_helper'

RSpec.describe "BacklogEntries", type: :request do
  fixtures :users

  let(:user) { users(:one) }

  before do
    sign_in_as user
  end

  describe "POST /" do
    it "create a backlog entry" do
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
end
