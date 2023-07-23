class ChangeDurationFromWalks < ActiveRecord::Migration[7.0]
  def down
    change_column :walks, :duration, :float, null: false
  end
  
  def up
    change_column_default :walks, :duration, nil
    change_column :walks, :duration, :decimal, null:false
    change_column :walks, :duration, :decimal, precision: 21, scale: 2, default: 0.0
  end
end
