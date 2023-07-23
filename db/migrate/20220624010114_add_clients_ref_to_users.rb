class AddClientsRefToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :client, index: true
    add_foreign_key :users, :clients
  end
end
