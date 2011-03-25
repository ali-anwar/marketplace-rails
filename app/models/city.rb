class City < ActiveRecord::Base
  has_many :ads

  def self.name_from_crc(crc)
    grouped = City.all.group_by {|city| city.name.to_crc32}
    grouped[crc.to_i].first.name
  end

  def self.region_from_crc(crc)
    grouped = City.all.group_by {|city| city.region.to_crc32}
    grouped[crc.to_i].first.region
  end
end
