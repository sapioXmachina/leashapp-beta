class AddPetReferenceToClient < ActiveRecord::Migration[7.0]
  def change
    add_reference :clients, :pet, foreign_key: true
  end
end
