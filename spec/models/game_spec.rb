require 'rails_helper'

RSpec.describe Game, type: :model do
  fixtures :users

  it "is valid with valid attributes" do
    game = Game.new(external_id: "123", name: "Zelda")

    expect(game).to be_valid
  end

  it "is invalid without external_id" do
    game = Game.new(name: "Zelda")

    expect(game).not_to be_valid
  end

  it "does not allow duplicate external_id" do
    Game.create!(external_id: "123", name: "Zelda")

    duplicate_game = Game.new(external_id: "123", name: "Mario")

    expect(duplicate_game).not_to be_valid
  end

  it "is invalid without name" do
    game = Game.new(external_id: 123)

    expect(game).not_to be_valid
  end

  describe ".unused" do
    it "returns games with no backlog entries" do
      user = users(:one)

      unused_game = Game.create!(external_id: "u1", name: "Unused Game")
      used_game = Game.create!(external_id: "u2", name: "Used game")

      BacklogEntry.create!(user: user, game: used_game)

      result = Game.unused

      expect(result).to include(unused_game)
      expect(result).not_to include(used_game)
    end
  end

  describe ".stale_unused" do
    it "returns only unused games older than 7 days" do
      user = users(:one)

      stale_unused = Game.create!(
        name: "Stale Unused",
        external_id: "s1",
        created_at: 8.days.ago
      )

      recent_unused = Game.create!(
        name: "Recent Unused",
        external_id: "s2",
        created_at: 1.day.ago
      )

      stale_used = Game.create!(
        name: "Stale Used",
        external_id: "s3",
        created_at: 8.days.ago
      )

      BacklogEntry.create!(user: user, game: stale_used)

      result = Game.stale_unused

      expect(result).to include(stale_unused)
      expect(result).not_to include(recent_unused)
      expect(result).not_to include(stale_used)
    end
  end
end
