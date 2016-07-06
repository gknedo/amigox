class RemoveListsFromExchange < ActiveRecord::Migration[5.0]
  def change
    remove_column :exchanges, :admins, :string
    remove_column :exchanges, :requests, :string
    remove_column :exchanges, :participants, :string
    remove_column :exchanges, :guests, :string
  end
end
