class RealestateByZipcode::Property
	
	attr_accessor :price, :lcation, :url, :beds, :baths, :year_built, :property_size, :floors, :last_transaction, :last_transaction_purchase_price
  
  @@properties = []

	def initialize(location=nil, price=nil, url=nil)

  	@location = location
  	@price = price
  	@url = url
    
    self.class.add_property(self)

	end
  
  def self.new_from_index_page(property)

		location = property.css("span[itemprop='name']").text + property.css("div.cityStZip").text 
		price = property.css("div.price").text.strip                                              
		url = property.css("div.alignForTwoPhotos a").attribute("href").value                      

		self.new(location, price, url)

  end
 
  def self.delete_properties

  	puts "Are you sure you want to erase properties?"
  	input = gets.strip.downcase
    @@properties.clear	if input == "yes"

  end

  def self.properties

  	@@properties.dup.freeze

  end

  def self.add_property(property)
	 
	  if !property.is_a?(RealestateByZipcode::Property)
	    raise "invalid property" 
	  else   
	    @@properties << property
	  end  

  end

  def doc

  	@doc ||= Nokogiri::HTML(open(@url))

  end

  def beds

    @beds ||= self.doc.css("div.description.floatClear ul")[1].css("li")[1].text

  end


end