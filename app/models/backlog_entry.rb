class BacklogEntry < ApplicationRecord
  belongs_to :user
  belongs_to :game

  enum :status, [ :to_play, :playing, :finished ]

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :game_id }
end
