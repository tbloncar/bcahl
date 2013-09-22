class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.text :description
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
  end
end
