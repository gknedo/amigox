class AddListsToExchanges < ActiveRecord::Migration[5.0]
  def change
    add_column :exchanges, :admins, :integer, array: true, default: []
    add_column :exchanges, :participants, :integer, array: true, default: []
    add_column :exchanges, :invites, :integer, array: true, default: []
    add_column :exchanges, :requests, :integer, array: true, default: []
  end
end
