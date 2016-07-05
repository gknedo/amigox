class RemoveRaffleFromExchanges < ActiveRecord::Migration[5.0]
  def change
    remove_column :exchanges, :raffle, :string
  end
end
