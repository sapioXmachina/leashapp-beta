class AddSubtotalToWalks < ActiveRecord::Migration[7.0]
  def change
    add_column :walks, :subtotal, :integer
    add_index :walks, :subtotal
  end
end
