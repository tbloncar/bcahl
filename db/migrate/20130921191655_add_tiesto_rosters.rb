class AddTiestoRosters < ActiveRecord::Migration
  def change
  	add_column :rosters, :ties, :integer, default: 0
  end
end
