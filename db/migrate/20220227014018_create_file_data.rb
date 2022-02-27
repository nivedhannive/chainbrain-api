class CreateFileData < ActiveRecord::Migration[7.0]
  def change
    create_table :file_data do |t|
      t.references :file_tracker, null: false, foreign_key: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
