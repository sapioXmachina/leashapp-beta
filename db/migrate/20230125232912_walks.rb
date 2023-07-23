class Walks < ActiveRecord::Migration[7.0]
  def change
    create_table "walks", force: :cascade do |t|
      t.datetime "startdatetime", null: false
      t.string "group", default: ""
      t.decimal "duration", default: 0.0, precision: 21, scale: 2, null: false
      t.string "notes"
      t.string "status", default: "Scheduled"
      t.timestamps
    end
    
    add_index :walks, :id, unique: true
    add_index :walks, :startdatetime
    add_index :walks, :group
    add_index :walks, :duration
    add_index :walks, :notes
    add_index :walks, :status
    
    add_reference :walks, :pet, foreign_key: true
  end
end
