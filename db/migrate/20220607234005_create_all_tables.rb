class CreateAllTables < ActiveRecord::Migration[7.0]
  def change
    create_table "clients", force: :cascade do |t|
      t.string "name", default: "", null: false
      t.string "email", default: "", null: false
      t.string "phone1", default: "" , null: false
      t.string "phone2"
      t.string "address", default: "" , null: false
      t.string "emergcontact_name"
      t.string "emergcontact_phone"
      t.string "pets"
      t.string "schedule"
      t.float "rates"
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
    add_index :clients, :emergcontact_name
    add_index :clients, :emergcontact_phone
    add_index :clients, :pets
    add_index :clients, :schedule
    add_index :clients, :rates
    add_index :clients, :payment_method
    add_index :clients, :allowance
    
    create_table "pets", force: :cascade do |t|
      t.string "name", default: "", null: false
      t.string "client", default: "", null: false
      t.string "nickname"
      t.string "photo"
      t.string "breed", default: "", null: false
      t.string "sex", default: "", null: false
      t.string "neutered", default: "", null: false
      t.float "age", default: "", null: false
      t.datetime "birthday"
      t.float "weight", default: "", null: false
      t.string "coat"
      t.string "eyecolor"
      t.string "features"
      t.string "allergies"
      t.string "medicalhistory"
      t.string "groups", default: "", null: false
      t.string "puppies", default: "", null: false
      t.string "toys"
      t.string "treats"
      t.string "notes"
      t.string "schedule"
      
      t.timestamps
    end
    
    add_index :pets, :id, unique: true
    add_index :pets, :name
    add_index :pets, :client
    add_index :pets, :nickname
    add_index :pets, :breed
    add_index :pets, :sex
    add_index :pets, :neutered
    add_index :pets, :age
    add_index :pets, :birthday
    add_index :pets, :weight
    add_index :pets, :coat
    add_index :pets, :eyecolor
    add_index :pets, :features
    add_index :pets, :allergies
    add_index :pets, :medicalhistory
    add_index :pets, :groups
    add_index :pets, :puppies
    add_index :pets, :toys
    add_index :pets, :treats
    add_index :pets, :notes
    add_index :pets, :schedule
    
    create_table "walks", force: :cascade do |t|
      t.datetime "startdatetime"
      t.string "client", default: "", null: false
      t.string "pet", default: "", null: false
      t.string "group", default: "", null: false
      t.float "duration", default: "", null: false
      t.string "notes"
      
      t.timestamps
    end
    
    add_index :walks, :id, unique: true
    add_index :walks, :startdatetime
    add_index :walks, :client
    add_index :walks, :pet
    add_index :walks, :group
    add_index :walks, :duration
    add_index :walks, :notes
  end
end
