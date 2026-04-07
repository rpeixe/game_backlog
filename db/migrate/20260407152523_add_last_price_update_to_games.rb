class AddLastPriceUpdateToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :last_price_update, :datetime
  end
end
