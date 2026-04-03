require 'rails_helper'

RSpec.describe BacklogEntry, type: :model do
  fixtures :users, :games, :backlog_entries

  it "is valid with valid attributes" do
    user = users(:two)
    game = games(:zelda)

    entry = BacklogEntry.new(user: user, game: game, status: :to_play)

    expect(entry).to be_valid
  end

  it "does not allow duplicate user/game pairs" do
    existing_entry = backlog_entries(:one)

    duplicate_entry = BacklogEntry.new(
      user: existing_entry.user,
      game: existing_entry.game,
      status: :to_play)

    expect(duplicate_entry).not_to be_valid
  end

  it "defaults status to to_play" do
    user = users(:two)
    game = games(:zelda)

    entry = BacklogEntry.new(user: user, game: game)

    expect(entry.status).to eq("to_play")
  end

  it "defaults status to playing" do
    user = users(:two)
    game = games(:zelda)
    entry = BacklogEntry.new(user: user, game: game, status: :to_play)

    entry.playing!

    expect(entry.status).to eq("playing")
  end
end
