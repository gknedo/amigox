class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.integer :participants, array: true, default: []
      t.integer :admins, array: true, default: []

      t.timestamps
    end
  end
end
