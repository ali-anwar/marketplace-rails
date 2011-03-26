class AddDeltaToAds < ActiveRecord::Migration
  def self.up
    add_column :ads, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :ads, :delta
  end
end
