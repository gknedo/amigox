class AddInvitesAndRaffleToExchanges < ActiveRecord::Migration[5.0]
  def change
    add_column :exchanges, :guests, :string, array: true, default: []
    add_column :exchanges, :requests, :string, array: true, default: []
    add_column :exchanges, :secret, :boolean, default: false
    add_column :exchanges, :raffled, :boolean, default: false
    add_column :exchanges, :exposed, :boolean, default: false
  end
end
