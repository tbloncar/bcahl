class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :f_name
      t.string :l_name
      t.string :full_name
      t.string :email
      t.string :path

      t.timestamps
    end
  end
end
