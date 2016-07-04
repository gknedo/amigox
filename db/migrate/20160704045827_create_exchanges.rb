class CreateExchanges < ActiveRecord::Migration[5.0]
  def change
    create_table :exchanges do |t|
      t.string :admins, array: true, default: []
      t.string :participants, array: true, default: []
      t.datetime :raffle, default: 14.days.from_now
      t.timestamps
    end
  end
end
