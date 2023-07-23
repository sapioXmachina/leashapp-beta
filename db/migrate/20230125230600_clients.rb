class Clients < ActiveRecord::Migration[7.0]
  def change
    create_table "clients", force: :cascade do |t|
      t.string "name", default: "", null: false
      t.string "email", default: "", null: false
      t.string "phone1", default: "" , null: false
      t.string "phone2"
      t.string "address"
      t.string "address2"
      t.string "city"
      t.string "state"
      t.string "zipcode"
      t.string "emergcontact_name"
      t.string "emergcontact_phone"
      t.string "schedule"
      t.float "rate"
      t.string "payment_method"
      t.integer "allowance"
      t.timestamps
    end
    
    add_index :clients, :id, unique: true
    add_index :clients, :name
    add_index :clients, :email, unique: true
    add_index :clients, :phone1
    add_index :clients, :phone2
    add_index :clients, :address
    add_index :clients, :address2
    add_index :clients, :city
    add_index :clients, :state
    add_index :clients, :zipcode
    add_index :clients, :emergcontact_name
    add_index :clients, :emergcontact_phone
    add_index :clients, :schedule
    add_index :clients, :rate
    add_index :clients, :payment_method
    add_index :clients, :allowance
    
    add_reference :clients, :account, foreign_key: true
  end
end
