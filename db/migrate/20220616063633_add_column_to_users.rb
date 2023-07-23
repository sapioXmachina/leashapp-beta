class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :leash_acct, :string, default: ""
    add_index :users, :leash_acct
    
    add_column :clients, :leash_acct, :string, default: ""
    add_index :clients, :leash_acct
  end
end
