class AddReferencesToUsersAndClients < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :client, foreign_key: true
    add_reference :clients, :user, foreign_key: true
  end
end
