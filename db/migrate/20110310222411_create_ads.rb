class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.boolean :show_phone
      t.integer :category_id
      t.integer :city_id
      t.string :title
      t.text :description
      t.float :price
      t.boolean :approved
      t.boolean :private

      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end
