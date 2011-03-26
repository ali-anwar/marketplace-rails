class Detail < ActiveRecord::Base
  after_save :set_ad_delta_flag

  belongs_to :ad

  private

  def set_ad_delta_flag
    ad.delta = true
    ad.save
  end

end
