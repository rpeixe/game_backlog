require 'rails_helper'

RSpec.describe CleanupGamesJob, type: :job do
  fixtures :users

  it "deletes only stale unused games" do
    stale_unused_game = Game.create!(
      external_id: "t1",
      name: "Stale Unused Game",
      created_at: 8.days.ago
    )

    recent_unused_game = Game.create!(
      external_id: "t2",
      name: "Recent Unused Game",
      created_at: 1.day.ago
    )

    used_game = Game.create!(
      external_id: "t3",
      name: "Used Game",
      created_at: 8.days.ago
    )

    BacklogEntry.create!(user: users(:one), game: used_game)

    expect {
      described_class.perform_now
    }.to change(Game, :count).by(-1)

    expect(Game.exists?(stale_unused_game.id)).to be_falsey
    expect(Game.exists?(recent_unused_game.id)).to be_truthy
    expect(Game.exists?(used_game.id)).to be_truthy
  end
end
