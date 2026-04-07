class AddCheapestPriceToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :cheapest_price, :decimal, precision: 8, scale: 2
  end
end
