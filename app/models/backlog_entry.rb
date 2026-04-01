class BacklogEntry < ApplicationRecord
  belongs_to :user
  belongs_to :game

  enum :status, [ :to_play, :playing, :finished ]
end
