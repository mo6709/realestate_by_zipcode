class RealestateByZipcode::Property
	
	attr_accessor :price, :lcation, :url, :beds, :baths, :year_built, :property_size, :floors, :last_transaction, :last_transaction_purchase_price
  
  @@all = []

	def initialize(price=nil, location=nil, url=nil)

  	@location = location
  	@price = price
  	@url = url

    # add_property(self)

	end
  
  def self.new_from_index_page(property)

		self.new(
			property.css("div.cityStZip").text, #=> it should return a location
			property.css("div.cityStZip").text, #=> it should return a price
			property.css("div.cityStZip").text #=> it should return a url
			)

  end
 

end