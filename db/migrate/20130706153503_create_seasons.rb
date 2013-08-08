class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.string :path
      t.integer :league_id
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
