require 'rails_helper'

RSpec.describe Review, type: :model do
  fixtures :users, :games

  it "is valid with valid attributes" do
    user = users(:two)
    game = games(:zelda)

    review = Review.new(user: user, game: game, rating: 5)

    expect(review).to be_valid
  end

  it "is invalid without rating" do
    user = users(:two)
    game = games(:zelda)

    review = Review.new(user: user, game: game)

    expect(review).not_to be_valid
  end

  it "is invalid with rating outside range" do
    user = users(:two)
    game = games(:zelda)

    review = Review.new(user: user, game: game, rating: 6)

    expect(review).not_to be_valid
  end
end
