class RealestateByZipcode::CLI
  
  #find out where would be the right place for this array to be
	@properties_types = ["single-family-home", "Multi-Family Home", "duplex", "townhouse",
		                   "coop-unit", "row-house", "condo-unit", "Patio Home", "Mobile/Manifactured Home",
		                   "Farm", "Houseboat", "Commercial Building", "Building Lot", "Row Land"] 

	def call

		puts "Hello and welcom to RealestateByZipcode"
		start

	end

	def start

		puts "What Zip-Code would you like expolre?"
		zipcode = gets.strop

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
	  puts "Row Land                  enter - 14"

	  input = gets.strip
    
    property_type = input_evaluation(input)

    RealestateByZipcode::Scraper.call(zipcode, property_type)

	end

	def input_evaluation(index)
     
     properties_types[index.to_s-1]

	end

end