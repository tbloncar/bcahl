class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :roster_spot_id
      t.integer :game_id
      t.integer :goals, default: 0
      t.integer :assists, default: 0
      t.integer :pim, default: 0

      t.timestamps null: false
    end

    add_index :participations, [:roster_spot_id, :game_id]
  end
end
