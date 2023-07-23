class AddColumnsToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :referral_key, :string, index: true
    add_column :accounts, :account_logo, :string, index: true
    add_column :accounts, :account_description, :string, index: true
    add_column :accounts, :account_rates, :float, index: true
    add_column :accounts, :account_admin, :integer, index: true
  end
end
