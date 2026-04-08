class AddDealInfoToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :store_id, :string
    add_column :games, :deal_id, :string
  end
end
