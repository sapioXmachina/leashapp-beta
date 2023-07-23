class AddColumnToWalks < ActiveRecord::Migration[7.0]
  def change
    add_column :walks, :leash_acct, :integer
    add_index :walks, :leash_acct
  end
end
