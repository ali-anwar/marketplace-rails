module MainHelper
  def map_city_url(name)
    ads_url(:search => {:city_region => name.to_crc32, :city_region_text => name})
  end

  def map_city_link(name, id=nil, out=nil, over=nil)
    extra_options = {:id => id}
    extra_options[:id] = id if id
    extra_options[:onmouseout] = "highlight_map(#{out})" if out
    extra_options[:onmouseover] = "highlight_map(#{over})" if over

    link_to name, map_city_url(name), extra_options
  end
end
