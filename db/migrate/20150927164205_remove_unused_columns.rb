class RemoveUnusedColumns < ActiveRecord::Migration
  def change
    remove_column :players, :full_name
    remove_column :roster_spots, :goals
    remove_column :roster_spots, :assists
    remove_column :roster_spots, :pim
  end
end
