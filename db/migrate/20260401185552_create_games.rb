class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.string :external_id, null: false
      t.string :name, null: false
      t.string :image_url

      t.timestamps
    end

    add_index :games, :external_id, unique: true
  end
end
