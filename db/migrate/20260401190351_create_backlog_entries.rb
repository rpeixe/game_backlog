class CreateBacklogEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :backlog_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :backlog_entries, [ :user_id, :game_id ], unique: true
  end
end
