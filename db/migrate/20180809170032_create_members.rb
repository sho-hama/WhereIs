class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members, id: false do |t|
      t.column :id, 'INTEGER PRIMARY KEY AUTOINCREMENT'
      t.text :name
      t.text :grade
      t.text :team
    end
  end
end
