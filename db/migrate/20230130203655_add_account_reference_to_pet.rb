class AddAccountReferenceToPet < ActiveRecord::Migration[7.0]
  def change
    add_reference :pets, :account, foreign_key: true
  end
end
