def get_details_for(c)
  years = (1970..Date.today.year).to_a
  detail_defaults = {:status => ['For sale', 'Want to buy'][rand(2)]}
  detail_basic_estates = {:status => ['For sale', 'For rent', 'Want to rent', 'Want to buy'][rand(4)],
                          :address => "Random address #{rand(10000)}",
                          :number_of_rooms => rand(20)+1,
                          :size => rand(300)}
  detail_basic_vehicles = {:status => ['For sale', 'Want to buy'][rand(2)],
                           :vehicle_registration_year => years[rand(years.length)],
                           :vehicle_mileage => rand(60000)
                          }
  detail_other_vehicles = {:status => ['For sale', 'Want to buy'][rand(2)],
                           :vehicle_category => ["Tractors", "Boats", "Caravans", "Buses and taxis"][rand(4)]}
  hash = {
          "Houses" => detail_basic_estates,
          "Apartments" => detail_basic_estates,
          "Vacation homes" => detail_basic_estates,
          "Offices" => detail_basic_estates,
          "Flatmates/Paying Guest" => detail_basic_estates,
          "Cars" => detail_basic_vehicles,
          "Motorcycles" => detail_basic_vehicles,
          "Trucks" => detail_basic_vehicles,
          "Other vehicles" => detail_other_vehicles,
          "Job offers" => {},
          "Resumes" => {},
  }

  hash[c.name] || detail_defaults
end

def get_bool
  [true, false][rand(2)]
end

def get_mostly_true_bool
  [true, true, true, true, true, false][rand(2)]
end


cities = City.all
categories = Category.all

users = (1..100).collect do |i|
  User.create :name => "User#{i}-(#{rand(10000)})", :email => "user#{i}@#{rand(10000)}.com", :password => "password", :password_confirmation => "password"
end

ads = (1..1000).collect do |i|
  category = categories[rand(categories.length)]
  city     = cities[rand(cities.length)]
  user     = users[rand(users.length)]
  details  = get_details_for(category)
  phone    = [rand(10),rand(10),rand(10),rand(10),rand(10),rand(10),rand(10),rand(10),rand(10)].join
  price    = [rand(1000), rand(100)].join('.').to_f
  title    = "Ad in #{category.name} and #{city.name}"
  title   += " with " + details.to_a.collect {|x| x[0].to_s.gsub('_', ' ') + ": " + x[1].to_s}.to_sentence unless details.empty?
  
  attributes = {"price"=>price, "name"=>user.name, :password => user.password, :password_confirmation => user.password, "title"=>title, "show_phone"=>get_bool, "private"=>get_bool, "approved"=>get_mostly_true_bool, "category_id"=>category.id, "phone"=>phone, "city_id"=>city.id, "email"=>user.email, :region => city.region, :detail => Detail.new(details)}

  ad = Ad.new attributes.merge("description" => attributes.to_a.collect {|x| x[0].to_s.gsub('_', ' ') + ": " + x[1].to_s}.join("<br/>"))
  ad.save
  puts ad.inspect
end
