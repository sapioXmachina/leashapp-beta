class AddUserRefToClients < ActiveRecord::Migration[7.0]
  def change
    add_reference :clients, :user, index: true
    add_foreign_key :clients, :users
  end
end
