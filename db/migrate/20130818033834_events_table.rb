class EventsTable < ActiveRecord::Migration
  def change
  	create_table :events do |t|
  		t.string :name
  		t.datetime :date_and_time
  		t.text :description
  		t.attachment :photo
  		t.string :path
  	end
  end
end
