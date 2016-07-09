class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :from
      t.integer :to
      t.text :content
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
