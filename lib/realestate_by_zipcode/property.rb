class RealestateByZipcode::Property
	
	attr_accessor :price, :lcation, :url, :beds, :baths, :year_built, :property_size, :floors, :last_transaction, :last_transaction_purchase_price
  
  @@all

	def initialize(price=nil, location=nil, url=nil)

	  	@location = location
	  	@price = price
	  	@url = url


	end

end