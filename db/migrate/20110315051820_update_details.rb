class UpdateDetails < ActiveRecord::Migration
  def self.up
    remove_column :details, :content

    add_column    :details, :status,                    :string
    add_column    :details, :address,                   :string
    add_column    :details, :number_of_rooms,           :integer
    add_column    :details, :size,                      :integer
    add_column    :details, :vehicle_registration_year, :integer
    add_column    :details, :vehicle_mileage,           :integer
    add_column    :details, :vehicle_category,          :integer
  end

  def self.down
    remove_column :details, :status
    remove_column :details, :address
    remove_column :details, :number_of_rooms
    remove_column :details, :size
    remove_column :details, :vehicle_registration_year
    remove_column :details, :vehicle_mileage
    remove_column :details, :vehicle_category

    add_column    :details, :content, :string
  end
end
