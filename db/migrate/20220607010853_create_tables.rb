class CreateTables < ActiveRecord::Migration[7.0]
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
	
	  create_table "users", force: :cascade do |t|
	  	t.string "name", null: false
	    t.string "email", null: false
	    t.string "client"
	    t.integer "role"
	    t.string "password_digest", null: false
	    t.timestamps
	  end
	  
	  add_index :users, :id, unique: true
    add_index :users, :name
    add_index :users, :email, unique: true
    add_index :users, :client
    add_index :users, :role
	end
end
