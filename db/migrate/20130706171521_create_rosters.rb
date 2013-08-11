class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.integer :season_id
      t.integer :team_id
      t.integer :wins, default: 0
      t.integer :losses, default: 0
      t.integer :points, default: 0
      t.integer :ot_losses, default: 0
      t.integer :so_wins, default: 0
      t.integer :goals_for, default: 0
      t.integer :goals_against, default: 0

      t.timestamps
    end
  end
end
