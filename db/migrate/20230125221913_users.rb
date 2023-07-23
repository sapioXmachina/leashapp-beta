class Users < ActiveRecord::Migration[7.0]
  def change
    create_table "users", force: :cascade do |t|
      t.string "name", null: false
      t.string "email", null: false
      t.string "account"
      t.integer "role"
      t.string "password_digest", null: false
      t.timestamps
    end
    
    add_index :users, :id, unique: true
    add_index :users, :name
    add_index :users, :email, unique: true
    add_index :users, :account
    add_index :users, :role
    
    add_reference :users, :account, foreign_key: true
  end
end
