class RealestateByZipcode::CLI
  
  #find out where would be the right place for this array to be mayby create hash in Property class
	@@properties_types = ["single-family-home", "multi-family-home", "duplex", "townhouse",
		                   "coop-unit", "row-house", "condo-unit", "patio", "mobile-home",
		                   "farm", "houseboat", "commercial", "building-lot", "raw-land"] 

	def call
		puts "*****************************"
		puts "Welcom to RealestateByZipcode"
		puts "*****************************"
	  start
    goodbey
	end
  
	def start
    initialize_properties
    display_properties
    
    property_index = "" 
    while property_index != "exit" 
      puts "---------------------Property's Details---------------------"
      puts "Please enter the property number for more details or 'exit' "
      puts "------------------------------------------------------------"
      property_index = gets.strip
      display_property(property_index)
    end
    puts "----------------------------------------------"
    puts "Would you like to explore a different zipcode?"
    puts "----------------------------------------------"
    start_over = gets.strip
    start if start_over.downcase == "yes"  
	end

	def initialize_properties  
    RealestateByZipcode::Property.delete_properties
    puts "-------------------------------------"
	  puts "What Zip-Code would you like explore?"
	  puts "-------------------------------------"
		zipcode = gets.strip

    if zipcode != "exit"
    	puts "------------------------------------------"
	    puts "What type of property are you looking for?"
	    puts "------------------------------------------"
		  puts "| Single Family Home          enter - 1  |"
		  puts "| Multi-Family Home           enter - 2  |"
		  puts "| Duplex                      enter - 3  |"
		  puts "| Townhouse/Townhome          enter - 4  |"
		  puts "| Co-op unit                  enter - 5  |"
		  puts "| Row House                   enter - 6  |"
		  puts "| Condominium/Apartment       enter - 7  |"
		  puts "| Patio Home                  enter - 8  |"
		  puts "| Mobile/Manufactured Home    enter - 9  |"
		  puts "| Farm                        enter - 10 |"
		  puts "| Houseboat                   enter - 11 |"
		  puts "| Commercial Building         enter - 12 |"
		  puts "| Building Lot                enter - 13 |"
		  puts "| Raw Land                    enter - 14 |"
		  puts "------------------------------------------"
		  input = gets.strip

	    property_type = input_evaluation(input)
	    if RealestateByZipcode::Scraper.call(zipcode, property_type) == "404 Not Found"
	    	puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	    	puts " Sorry. No properties match your search :( "
	    	puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	    	initialize_properties
	    end
	  end

	end

	def display_properties
		puts "===================================================================================="
	  RealestateByZipcode::Property.properties.each.with_index(1) do |p, i|
	  	puts "| #{i}. #{p.price}   - #{p.location}"
	  end
    puts "===================================================================================="
	end

	def display_property(index)

    if index.to_i > 0  && index.to_i <= RealestateByZipcode::Property.properties.size
			p = RealestateByZipcode::Property.properties[index.to_i-1]
	    puts "========================#{p.location}=========================="
	    puts "Price:                           #{p.price}"
	    puts "Beds:                            #{p.beds}"
	    puts "Baths:                           #{p.baths}"
	    puts "Year built:                      #{p.year_built}"
	    puts "Property size:                   #{p.property_size}"
	    puts "Lot size:                        #{p.lot_size}"
	    puts "Contact Information:         #{p.contact_info}"
	    puts "Last transaction:                #{p.last_transaction}"
	    puts "Last transaction purchase price: #{p.last_transaction_purchase_price}"
	    puts ""
	    puts "------------------------------------------"
	    puts "Would you like to see a brief description?"
	    puts "------------------------------------------"
	    input = gets.strip
	    if input.downcase == "yes" 
	      puts "#{p.description}"
	      puts ""
	    end 
	  else
      puts "---------------------------"
	    puts "Please enter a valid number"
	    puts "---------------------------"  
	  end
	end

	def input_evaluation(index)	     
	  @@properties_types[index.to_i-1]
	end
  
  def goodbey
  	puts "*******************"
  	puts "     GOODBEY! "
  	puts "*******************"
  end

end