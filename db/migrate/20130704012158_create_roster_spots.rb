class CreateRosterSpots < ActiveRecord::Migration
  def change
    create_table :roster_spots do |t|
      t.integer :player_id
      t.integer :roster_id
      t.boolean :captain, default: false
      t.integer :goals, default: 0
      t.integer :assists, default: 0
      t.integer :pim, default: 0

      t.timestamps
    end
  end
end
