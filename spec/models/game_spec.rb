require 'rails_helper'

RSpec.describe Game, type: :model do
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
end
