class Upload < ActiveRecord::Base
  belongs_to :ad
  has_attached_file :photo,
                    :styles => {
                      :thumb  => ["100x100>", :jpg],
                      :normal => ["640x480>", :jpg],
                    },
                    :default_style => :normal
end

