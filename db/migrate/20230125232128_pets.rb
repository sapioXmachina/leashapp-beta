class Pets < ActiveRecord::Migration[7.0]
  def change
    create_table "pets", force: :cascade do |t|
      t.string "name", default: "", null: false
      t.string "nickname"
      t.string "photo"
      t.string "breed", default: ""
      t.string "sex", default: ""
      t.string "neutered", default: ""
      t.float "age", default: ""
      t.datetime "birthday"
      t.float "weight", default: ""
      t.string "coat"
      t.string "eyecolor"
      t.string "features"
      t.string "allergies"
      t.string "medical_history"
      t.string "groups", default: ""
      t.string "puppies", default: ""
      t.string "toys"
      t.string "treats"
      t.string "notes"
      t.string "schedule"
      t.timestamps
    end
    
    add_index :pets, :id, unique: true
    add_index :pets, :name
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
    add_index :pets, :medical_history
    add_index :pets, :groups
    add_index :pets, :puppies
    add_index :pets, :toys
    add_index :pets, :treats
    add_index :pets, :notes
    add_index :pets, :schedule
    
    add_reference :pets, :client, foreign_key: true
  end
end
