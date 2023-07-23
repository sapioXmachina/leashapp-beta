class Accounts < ActiveRecord::Migration[7.0]
  def change
    create_table "currents", force: :cascade do |t|
      t.timestamps
    end
    
    create_table "mains", force: :cascade do |t|
      t.timestamps
    end
    
    create_table "password_resets", force: :cascade do |t|
      t.timestamps
    end
    
    create_table "passwords", force: :cascade do |t|
      t.timestamps
    end
    
    create_table "sessions", force: :cascade do |t|
      t.timestamps
    end
    
    create_table "accounts", force: :cascade do |t|
      t.string "account_name", null: false
      t.timestamps
    end
    
    add_index :accounts, :account_name, unique: true
  end
end
