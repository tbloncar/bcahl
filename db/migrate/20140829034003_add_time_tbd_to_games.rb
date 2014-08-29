class AddTimeTbdToGames < ActiveRecord::Migration
  def change
    add_column :games, :time_tbd, :boolean
    add_index :games, :time_tbd
  end
end
