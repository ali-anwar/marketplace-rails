class Category < ActiveRecord::Base
  has_many :ads

  def self.name_from_crc(crc)
    grouped = Category.all.group_by {|category| category.name.to_crc32}
    grouped[crc.to_i].first.name
  end

  def self.parent_from_crc(crc)
    grouped = Category.all.group_by {|category| category.parent.to_crc32}
    grouped[crc.to_i].first.parent
  end
end
