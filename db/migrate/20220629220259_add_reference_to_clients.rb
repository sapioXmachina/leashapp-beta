class AddReferenceToClients < ActiveRecord::Migration[7.0]
  def change
    add_reference :clients, :pet, index: true
    add_foreign_key :clients, :pets
  end
end
