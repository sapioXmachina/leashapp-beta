class ChangeColumnFromClients < ActiveRecord::Migration[7.0]
  def down
    change_column :clients, :rates, :float
  end
  
  def up
    change_column_default :clients, :rates, nil
    change_column :clients, :rates, :decimal
    change_column :clients, :rates, :decimal, precision: 21, scale: 2, default: 0.0
  end
end
