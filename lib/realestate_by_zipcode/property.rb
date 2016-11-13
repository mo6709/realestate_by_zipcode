class RealestateByZipcode::Property
	
	attr_accessor :price, :location, :url, :description, :beds, :baths, :year_built, :property_size, :lot_size, :floors, :last_transaction, :last_transaction_purchase_price
  
  @@properties = []

	def initialize(location=nil, price=nil, url=nil)

  	@location = location
  	@price = price
  	@url = url
    
    self.class.add_property(self)

	end
  
  def self.new_from_index_page(property)

		location = property.css("span[itemprop='name']").text + property.css("div.cityStZip").text.strip 
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
  

  def description

  	@description ||= self.doc.css("div.description.floatClear p").text

  end

  def beds

    @beds ||= self.doc.css("div.description.floatClear ul")[1].css("li")[1].text.match(/\d+/)[0]

  end

  def baths

  	@baths ||= self.doc.css("div.description.floatClear ul")[1].css("li")[2].text.match(/\d+/)[0]

  end

  def year_built

    @year_built ||= self.doc.css("div.description.floatClear ul")[0].css("li")[1].text.match(/\d+/)[0]

  end

  def home_size

  	@home_size ||= self.doc.css("div[data-tab-name='publicFacts'] div.attributes dl")[7].css("dd").text.strip

  end

  def lot_size

  	@lot_size ||= self.doc.css("div[data-tab-name='publicFacts'] div.attributes dl")[8].css("dd").text.strip

  end

  def floors

  	@floors ||= self.doc.css("div[data-tab-name='publicFacts'] div.attributes dl")[6].css("dd").text.strip

  end

  def last_transaction

  	@last_transaction ||= self.doc.css("div[data-tab-name='publicFacts'] div.attributes dl")[2].css("dd").text.strip

  end

  def last_transaction_purchase_price

    @last_transaction_purchase_price ||= self.doc.css("div[data-tab-name='publicFacts'] div.attributes dl")[3].css("dd").text.strip 

  end

end