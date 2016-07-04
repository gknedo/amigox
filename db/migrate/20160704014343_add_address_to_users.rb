class AddAddressToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address_street, :string
    add_column :users, :address_number, :integer
    add_column :users, :address_aditional, :string
    add_column :users, :address_zip, :string
    add_column :users, :address_city, :string
    add_column :users, :address_state, :string
    add_column :users, :address_country, :string
  end
end
