class AddClientReferenceToWalks < ActiveRecord::Migration[7.0]
  def change
    add_reference :walks, :client, foreign_key: true
  end
end
