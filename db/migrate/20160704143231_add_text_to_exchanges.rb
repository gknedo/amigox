class AddTextToExchanges < ActiveRecord::Migration[5.0]
  def change
    add_column :exchanges, :title, :string
    add_column :exchanges, :description, :text
    add_column :users, :about, :text
  end
end
