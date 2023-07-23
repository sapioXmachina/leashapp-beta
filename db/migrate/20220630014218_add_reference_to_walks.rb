class AddReferenceToWalks < ActiveRecord::Migration[7.0]
  def change
    add_reference :walks, :pet, index: true
    add_foreign_key :walks, :pets
    
    add_reference :walks, :client, index: true
    add_foreign_key :walks, :clients
  end
end
