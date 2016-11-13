class RealestateByZipcode::CLI
  
  #find out where would be the right place for this array to be mayby create hash in Property class
	@@properties_types = ["single-family-home", "multi-family-home", "duplex", "townhouse",
		                   "coop-unit", "row-house", "condo-unit", "patio", "mobile-home",
		                   "farm", "houseboat", "commercial", "building-lot", "raw-land"] 

	def call

		puts "Welcom to RealestateByZipcode"
	  start

	end

	def start

		puts "What Zip-Code would you like expolre?"
		zipcode = gets.strip

    puts "What type of property are you looking for?"
	  puts "Single Family Home        enter - 1"
	  puts "Multi-Family Home         enter - 2"
	  puts "Duplex enter              enter - 3"
	  puts "Twonhous/Twonhome         enter - 4"
	  puts "Co-op unit                enter - 5"
	  puts "Row House                 enter - 6"
	  puts "Condominium/Apartment     enter - 7"
	  puts "Patio Home                enter - 8"
	  puts "Mobile/Manifactured Home  enter - 9"
	  puts "Farm                      enter - 10"
	  puts "Houseboat                 enter - 11"
	  puts "Commercial Building       enter - 12"
	  puts "Building Lot              enter - 13"
	  puts "Raw Land                  enter - 14"

	  input = gets.strip
    
    property_type = input_evaluation(input)

    RealestateByZipcode::Scraper.call(zipcode, property_type)

    display_properties 



	end

	def input_evaluation(index)
     
     @@properties_types[index.to_i-1]

	end

	def display_properties

	  RealestateByZipcode::Property.properties.each.with_index(1) do |p, i|
	  	puts "#{i}. #{p.price}   - #{p.location}"
	  end
    puts "----------------------------------------------------------"

	end
 




end