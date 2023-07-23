class AddReferenceToPets < ActiveRecord::Migration[7.0]
  def change
    add_reference :pets, :client, index: true
    add_foreign_key :pets, :clients
  end
end
