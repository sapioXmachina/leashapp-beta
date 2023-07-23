class AddReferralKeyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :referral_key, :string, index: true
  end
end
