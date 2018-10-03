class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations, id: false do |t|
      t.column :id, 'INTEGER PRIMARY KEY AUTOINCREMENT'
      t.integer :member_id
      t.text :place
      t.datetime :time
      t.text :address
      t.float :latitude
      t.float :longitude
    end
  end
end
