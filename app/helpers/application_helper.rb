module ApplicationHelper
  def category_select_box(options = {})
    options_for_select_box = Category.all.group_by(&:parent).collect do |parent, categories|
      disabled             = "disabled='disabled'" if options[:parent_disabled]
      style                = "style='background-color: rgb(220, 220, 195); font-weight: bold;'"
      main_category_option = "<option #{disabled} #{style}>-- #{parent} --</option>"
      category_options     = categories.collect {|c| "<option parent='#{parent}' #{'selected="selected"' if options[:value].to_i == c.id} value='#{c.id}'>#{c.name}</option>" }.join
      [main_category_option, category_options].join
    end.join

    select options[:model], options[:attribute], options_for_select_box, {:include_blank => '« All categories »'}
  end

  def regions_select_box(options = {})
    options_for_select_box = City.all.collect(&:region).uniq.sort.each_with_index.collect {|r, index| i = index+1; "<option #{'selected="selected"' if options[:value].to_i == i} value='#{i}'>#{r}</option>" }.join
    select options[:model], options[:attribute], options_for_select_box, {:include_blank => '« Choose »'}, :class => 'regions_select_box'
  end

  def cities_select_box(options = {})
    City.all.group_by(&:region).sort.each_with_index.collect do |(region, cities), i|
      options_for_select_box =  cities.sort_by(&:id).collect {|c| "<option #{'selected="selected"' if options[:value].to_i == c.id} value='#{c.id}'>#{c.name}</option>" }.join
      content_tag(:div, select(options[:model], options[:attribute], options_for_select_box, {:include_blank => '« Choose city »'}), :id => "region-#{i+1}", :class => "invisible region_div")
    end.join
  end

  def currency(price)
    "Rs. " + number_with_delimiter(price)
  end
end
