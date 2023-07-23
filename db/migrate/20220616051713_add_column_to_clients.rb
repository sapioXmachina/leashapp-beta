class AddColumnToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :address2, :string, default: ""
    add_column :clients, :city, :string, default: ""
    add_column :clients, :state, :string, default: ""
    add_column :clients, :zipcode, :string, default: ""
    
    add_index :clients, :address2
    add_index :clients, :city
    add_index :clients, :state
    add_index :clients, :zipcode
  end
end
