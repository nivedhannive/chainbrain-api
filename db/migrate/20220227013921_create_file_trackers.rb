class CreateFileTrackers < ActiveRecord::Migration[7.0]
  def change
    create_table :file_trackers do |t|
      t.string :status

      t.timestamps
    end
  end
end
