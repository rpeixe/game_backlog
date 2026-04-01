class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :backlog_entries, dependent: :destroy
  has_many :games, through: :backlog_entries
  has_many :reviews, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
