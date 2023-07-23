class AddStatusToWalks < ActiveRecord::Migration[7.0]
  def change
    add_column :walks, :status, :string, default: "Scheduled"
    add_index :walks, :status
  end
end
