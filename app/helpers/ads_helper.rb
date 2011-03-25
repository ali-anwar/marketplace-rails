module AdsHelper

  def min_price_select_tag(name, v)
    options_array = [['Min price', '']]

    [[(1...4), 25000], [(2...4), 50000], [(2...15), 100000], [(7...15), 250000]].each do |(range, multiplier)|
      options_array = options_array + range.collect do |i|
        [number_with_delimiter(i*multiplier), i*multiplier]
      end
    end

    options_for_select_tag = options_array.collect do |(text, value)|
      selected = "selected='selected'" if !v.blank? && v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def max_price_select_tag(name, v)
    options_array = [['Max price', '']]

    [[(2...4), 25000], [(2...4), 50000], [(2...15), 100000], [(7...15), 250000]].each do |(range, multiplier)|
      options_array = options_array + range.collect do |i|
        [number_with_delimiter(i*multiplier), i*multiplier]
      end
    end

  options_array = options_array + [['More than 3,500,000', 3500001]]

    options_for_select_tag = options_array.collect do |(text, value)|
      selected = "selected='selected'" if !v.blank? && v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def mileage_from_select_tag(name, v)
    options_array = [['Mileage from', '']]

    [[(0...20), 500], [(10...20), 1000], [(4...11), 5000]].each do |(range, multiplier)|
      options_array = options_array + range.collect do |i|
        [number_with_delimiter(i*multiplier), i*multiplier]
      end
    end

    options_for_select_tag = options_array.collect do |(text, value)|
      selected = "selected='selected'" if !v.blank? && v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end


  def mileage_to_select_tag(name, v)
    options_array = [['Mileage to', '']]

    [[(1...20), 500], [(10...20), 1000], [(4...11), 5000]].each do |(range, multiplier)|
      options_array = options_array + range.collect do |i|
        [number_with_delimiter(i*multiplier-1), i*multiplier-1]
      end
    end

  options_array = options_array + [['More than 50,000', 50001]]

    options_for_select_tag = options_array.collect do |(text, value)|
      selected = "selected='selected'" if !v.blank? && v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def reg_year_from_select_tag(name, v)
    options_array = [['Reg year from', '']] + [['1980 or older', '1980']] + (1981..Date.today.year).collect {|i| [i, i]}
    options_for_select_tag = options_array.collect do |(text, value)|
      selected = "selected='selected'" if v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def reg_year_to_select_tag(name, v)
    options_array = [['Reg year to', '']] + (1981..Date.today.year).collect {|i| [i, i]}
    options_for_select_tag = options_array.collect do |(text, value)|
      selected = "selected='selected'" if v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def number_of_rooms_select_tag(name, v)
    options_for_select_tag = ([['« Choose »', '']] + (1..10).collect {|i| [i, i]} + [['More than 10', 11]]).collect do |(text, value)|
      selected = "selected='selected'" if v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def min_rooms_select_tag(name, v)
    options_for_select_tag = ([['Min rooms', '']] + (1..10).collect {|i| [i, i]}).collect do |(text, value)|
      selected = "selected='selected'" if !v.blank? && v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def max_rooms_select_tag(name, v)
    options_for_select_tag = ([['Max rooms', '']] + (1..10).collect {|i| [i, i]} + [['More than 10', 11]]).collect do |(text, value)|
      selected = "selected='selected'" if !v.blank? && v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end


  def min_living_size_select_tag(name, v)
    options_for_select_tag = ([['Min living size', '']] + [0,25,35,50,60,70,80,90,100,125,150,175,200].collect {|i| [i, i]}).collect do |(text, value)|
      selected = "selected='selected'" if !v.blank? && v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def max_living_size_select_tag(name, v)
    options_for_select_tag = ([['Max living size', '']] + [25,35,50,60,70,80,90,100,125,150,175,200].collect {|i| [i, i]} + [['More than 200', 201]]).collect do |(text, value)|
      selected = "selected='selected'" if !v.blank? && v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def vehicle_registration_year_select_tag(name, v)
    options_array = [['« Choose registration year »', '']] + [['1980 or older', '1980']] + (1981..Date.today.year).collect {|i| [i, i]}
    options_for_select_tag = options_array.collect do |(text, value)|
      selected = "selected='selected'" if v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def vehicle_mileage_select_tag(name, v)
    options_array = [['« Choose mileage »', '']]

    [[(0...20), 500], [(10...20), 1000], [(4...10), 5000]].each do |(range, multiplier)|
      options_array = options_array + range.collect do |i|
        f = number_with_delimiter(i*multiplier)
        l = number_with_delimiter((i+1)*multiplier-1)
        [[f, l].join(' - '), i*multiplier]
      end
    end

    options_array = options_array + [['More than 50,000', '50001']]

    options_for_select_tag = options_array.collect do |(text, value)|
      selected = "selected='selected'" if v && v.to_i == value.to_i
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def vehicle_category_select_tag(name, v, options = {})
    options_array = [['« All categories »', '']] + ["Tractors", "Boats", "Caravans", "Buses and taxis"].collect {|a| [a, a]}
    options_for_select_tag = options_array.collect do |(text, value)|
      value, v = [value.to_crc32, v.to_i] if options[:crc32]
      selected = "selected='selected'" if v == value
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

  def search_category_select_box
    options_for_select_box = Category.all.group_by(&:parent).collect do |parent, categories|
      value                = params[:search][:category_parent_name]
      style                = "style='background-color: rgb(220, 220, 195); font-weight: bold;'"
      selected             = "selected='selected'" if !value.blank? && value.to_i == parent.to_crc32
      main_category_option = "<option #{selected} #{style} value='' crc='#{parent.to_crc32}'>-- #{parent} --</option>"
      category_options     = categories.collect {|c| "<option crc='#{c.name.to_crc32}' parent='#{parent}' #{'selected="selected"' if params[:search][:category_name].to_i == c.name.to_crc32} value='#{c.name.to_crc32}'>#{c.name}</option>" }.join
      [main_category_option, category_options].join
    end.join

    options_for_select_box = "<option value='' crc=''>All categories</option>" + options_for_select_box

    [hidden_field(:search, :category_parent_name),
    select(:search, :category_name, options_for_select_box)].join
  end

  def search_regions_select_box
    regions = [['Andhra Pradesh', 'Andhra Pradesh'.to_crc32],
               ['Neighbouring regions', 'Neighbouring regions'.to_crc32],
               ['Entire India', ''],
              ] + (City.all.collect(&:region) - ['Andhra Pradesh']).uniq.sort.collect {|r| [r, r.to_crc32]}

    options_for_select_box = regions.each.collect do |(r, crc)|
      selected = "selected='selected'" if params[:search][:city_region].to_i == crc.to_i
      "<option #{selected} value='#{crc}' crc='#{r.to_crc32}'>#{r}</option>"
    end.join

    [hidden_field(:search, :city_region_text),
     select(:search, :city_region, options_for_select_box)].join
  end

  def search_cities_select_boxes
    City.all.group_by(&:region).sort.each_with_index.collect do |(region, cities), i|
      options_for_select_box =  cities.sort_by(&:id).collect {|c| "<option #{'selected="selected"' if params[:search][:city_name].to_i == c.name.to_crc32} value='#{c.name.to_crc32}'>#{c.name}</option>" }.join
      content_tag(:div, select(:search, :city_name, options_for_select_box, {:include_blank => 'All cities'}), :id => "region-#{region.to_crc32}")
    end.join
  end

  def pagination_links
    return "" if @ads.total_pages < 2

    links        = []
    options      = params.dup

    unless 1 == @ads.current_page
      options[:search][:page] = 1
      links << "<span class='first'>" + link_to("<< First Page", options) + "</span>"
      options[:search][:page] = @ads.current_page - 1
      links << "<span class='previous'>" + link_to("< Previous Page", options) + "</span>"
    end

    from        = [@ads.current_page - @ads.per_page/2, 1].max
    to          = [from + @ads.per_page - 1, @ads.total_pages].min
    from        = [to - @ads.per_page + 1, 1].max

    pages = (from..to).collect do |i|
      if @ads.current_page == i
        "<b>#{i}</b>"
      else
        options[:search][:page] = i
        link_to i, options
      end
    end.join(' ')

    links << "<span class='count'>" + pages + "</span>"

    unless @ads.total_pages == @ads.current_page
      options[:search][:page] = @ads.current_page + 1
      links << "<span class='next'>" + link_to("Next Page >", options) + "</span>"
      options[:search][:page] = @ads.total_pages
      links << "<span class='last'>" + link_to("Last Page >>", options) + "</span>"
    end

    links.join
  end

  def search_results_info
    return @ads.size if @ads.total_pages < 2
    "#{@ads.offset + 1} - #{@ads.offset + @ads.length} of #{@ads.total_entries}"
  end

  def search_tab_all
    options = params.dup
    options[:search].delete(:company)
    options[:search].delete(:private)

    text, active = if !params[:search].has_key?(:private) && !params[:search].has_key?(:company)
      ["All #{search_results_info}", 'active']
    else
      count = @all_facets[:private][true].to_i + @all_facets[:company][true].to_i
      return if count == 0
      ["All, #{count}", '']
    end

    url = url_for options
    "<li class='#{active}'><a href='#{url}'>#{text}</a></li>"
  end

  def search_tab_private
    options = params.dup
    options[:search].delete(:company)
    options[:search][:private] = true

    text, active = if params[:search].has_key?(:private)
      ["Private #{search_results_info}", 'active']
    else
      count = @all_facets[:private][true].to_i
      return if count == 0
      ["Private, #{count}", '']
    end

    url = url_for options
    "<li class='#{active}'><a href='#{url}'>#{text}</a></li>"
  end

  def search_tab_company
    options = params.dup
    options[:search][:company] = true
    options[:search].delete(:private)

    text, active = if params[:search].has_key?(:company)
      ["Company #{search_results_info}", 'active']
    else
      count = @all_facets[:company][true].to_i
      return if count == 0
      ["Company, #{count}", '']
    end

    url = url_for options
    "<li class='#{active}'><a href='#{url}'>#{text}</a></li>"
  end

  def search_tabs
    [search_tab_all, search_tab_private, search_tab_company].join
  end

  def search_url_with(options = {})
    o = params.dup
    o[:search] = o[:search].merge(options)
    url_for(o)
  end

  def category_grouped_by_parents_ordered
    categories_with_parents = Category.all.group_by(&:parent)
    ["Real estate", "Home & Personal items",  "Electronics",
     "Vehicles", "Leisure, Sports & hobby", "Jobs & Services",
     ""].collect {|parent| [parent, categories_with_parents[parent]]}
  end

  def get_region_name
    return "Entire India" if params[:search][:city_region_text].blank?
    params[:search][:city_region_text]
  end

  def get_region_value
    return "" if params[:search][:city_region_text].blank?
    params[:search][:city_region]
  end
end
