class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.integer :ad_id
      t.string :photo_file_name
      t.integer :photo_file_size
    end

    add_index :uploads, :ad_id
  end

  def self.down
    drop_table :uploads
  end
end
