class RealestateByZipcode::Property
	
	attr_accessor :price, :lcation, :url, :beds, :baths, :year_built, :property_size, :floors, :last_transaction, :last_transaction_purchase_price
  
  @@all = []

	def initialize(location=nil, price=nil, url=nil)

  	@location = location
  	@price = price
  	@url = url
   
    # add_property(self)

	end
  
  def self.new_from_index_page(property)

		location = property.css("span[itemprop='name']").text + property.css("div.cityStZip").text #=> it should return the location
		price = property.css("div.price").text.strip #=> it should return a price
		url = property.css("div.alignForTwoPhotos a").attribute("href").value #=> it should return a url

		self.new(location, price, url)

  end
 

end