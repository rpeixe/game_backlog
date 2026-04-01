class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :rating, presence: true, inclusion: { in: 1..5 }
end
