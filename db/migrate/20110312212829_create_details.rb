class CreateDetails < ActiveRecord::Migration
  def self.up
    create_table :details do |t|
      t.integer :ad_id
      t.string :content
    end

    add_index :details, :ad_id
  end

  def self.down
    drop_table :details
  end
end
