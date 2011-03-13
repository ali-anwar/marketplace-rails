module AdsHelper

  def number_of_rooms_select_tag(name, v)
    options_for_select_tag = ([['« Choose »', '']] + (1..10).collect {|i| [i, i]} + [['More than 10', 11]]).collect do |(text, value)|
      selected = "selected='selected'" if v.to_i == value.to_i
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

  def vehicle_category_select_tag(name, v)
    options_array = [['« All categories »', ''], ['Tractors', 'Tractors'], ['Boats', 'Boats'], ['Caravans', 'Caravans'], ['Buses and taxis', 'BusesAndTaxis']]
    options_for_select_tag = options_array.collect do |(text, value)|
      selected = "selected='selected'" if v == value
      "<option #{selected} value='#{value}'>#{text}</option>"
    end.join

    select_tag name, options_for_select_tag
  end

end
