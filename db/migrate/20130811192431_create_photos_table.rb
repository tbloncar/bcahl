class CreatePhotosTable < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.attachment :photo
    	t.text :description
    end
  end
end
