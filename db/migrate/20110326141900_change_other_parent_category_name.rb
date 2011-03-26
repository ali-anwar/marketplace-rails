class ChangeOtherParentCategoryName < ActiveRecord::Migration
  def self.up
     Category.update_all({:parent => " "}, {:parent => ""})
  end

  def self.down
     Category.update_all({:parent => ""}, {:parent => " "})
  end
end
