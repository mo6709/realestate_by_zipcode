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

    initialize_properties
    display_properties
    
    puts "Would you like to take a close look on a particular property?"
    input = gets.strip
    if input.downcase != "no"
    	property_index = ""
	    while property_index != "exit" 
	     puts "----------Property's Details------------"
	     puts "Please enter the property's index number"
	     property_index = gets.strip
	     display_property(property_index)
      end
    end  
    
	end

	def initialize_properties
    
	  puts "What Zip-Code would you like explore?"
		zipcode = gets.strip

    puts "What type of property are you looking for?"
    puts "------------------------------------------"
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

	end

	def display_properties

	  RealestateByZipcode::Property.properties.each.with_index(1) do |p, i|
	  	puts "#{i}. #{p.price}   - #{p.location}"
	  end
    puts "------------------------------------------------------------"

	end

	def display_property(index)

    if index.to_i > 0
			p = RealestateByZipcode::Property.properties[index.to_i-1]
	    puts "----------------------#{p.location}----------------------"
	    puts "Price:         #{p.price}"
	    puts "Beds:          #{p.beds}"
	    puts "Baths:         #{p.baths}"
	    puts "Year built:    #{p.year_built}"
	    puts "Property size: #{p.property_size}"
	    puts "Lot size:      #{p.lot_size}"
	    puts "Floors:        #{p.floors}"
	    puts "Last transaction:                #{p.last_transaction}"
	    puts "Last transaction purchase price: #{p.last_transaction_purchase_price}"
	    puts ""
	    puts "Would you like to see a brief description?"
	    input = gets.strip
	    if input.downcase == "yes" 
	      puts "#{p.description}"
	      puts ""
	    end   
	  end

	end

	def input_evaluation(index)
	     
	  @@properties_types[index.to_i-1]

	end

end