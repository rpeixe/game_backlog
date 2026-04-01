class Game < ApplicationRecord
  has_many :backlog_entries, dependent: :destroy
  has_many :users, through: :backlog_entries
  has_many :reviews, dependent: :destroy

  validates :external_id, presence: true, uniqueness: true
  validates :name, presence: true
end
