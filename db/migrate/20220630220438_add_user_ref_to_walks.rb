class AddUserRefToWalks < ActiveRecord::Migration[7.0]
  def change
    add_reference :walks, :user, index: true
    add_foreign_key :walks, :users
  end
  
end
