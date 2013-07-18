class CreateClientData < ActiveRecord::Migration
  def change
    create_table :client_data do |t|
      t.string :section
      t.text :data
      t.references :user

      t.timestamps
    end
    add_index :client_data, :user_id
  end
end
