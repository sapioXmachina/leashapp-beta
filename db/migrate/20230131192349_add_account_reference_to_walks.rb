class AddAccountReferenceToWalks < ActiveRecord::Migration[7.0]
  def change
    add_reference :walks, :account, foreign_key: true
  end
end
