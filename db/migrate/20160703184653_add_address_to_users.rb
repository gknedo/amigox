class AddAddressToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address_street, :string
    add_column :users, :address_number, :integer
    add_column :users, :address_street2, :string
    add_column :users, :address_city, :string
    add_column :users, :address_state, :string
    add_column :users, :address_country, :string
    add_column :users, :address_zip, :string
    add_column :users, :about, :string
  end
end
