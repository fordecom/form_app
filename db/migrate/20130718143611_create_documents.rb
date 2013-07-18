class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :filename
      t.string :doc_name
      t.string :original_filename
      t.references :users

      t.timestamps
    end
    add_index :documents, :users_id
  end
end
