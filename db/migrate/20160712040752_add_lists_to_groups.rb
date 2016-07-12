class AddListsToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :invites, :integer, array:true, default: []
    add_column :groups, :requests, :integer, array:true, default: []
  end
end
