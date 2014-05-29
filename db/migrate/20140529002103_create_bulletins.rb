class CreateBulletins < ActiveRecord::Migration
  def change
    create_table :bulletins do |t|
      t.text :message
      t.boolean :active

      t.timestamps
    end

    Bulletin.create(message: "")
  end
end
