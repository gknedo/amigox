class CreateRaffles < ActiveRecord::Migration[5.0]
  def change
    create_table :raffles do |t|
      t.integer :exchange
      t.integer :user
      t.integer :gift_to

      t.timestamps
    end
  end
end
