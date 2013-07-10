class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :season_id
      t.datetime :date_and_time
      t.boolean :ot
      t.integer :home_id
      t.integer :away_id
      t.integer :home_goals
      t.integer :away_goals

      t.timestamps
    end
  end
end
