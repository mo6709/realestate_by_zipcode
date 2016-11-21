class RealestateByZipcode::Property
	
	attr_accessor :price, 
	              :location,  
	              :url, 
	              :description, 
	              :beds, 
	              :baths,  
	              :year_built, 
	              :contact_info, 
	              :last_transaction, 
	              :last_transaction_purchase_price
  
  @@properties = []

  #find out where would be the right place for this array to be mayby create hash in Property class
	@@properties_types = ["single-family-home", "multi-family-home", "duplex", "townhouse",
		                   "coop-unit", "row-house", "condo-unit", "patio", "mobile-home",
		                   "farm", "houseboat", "commercial", "building-lot", "raw-land"] 

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
    @@properties.clear
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
  	begin 
  	  @description ||= self.doc.css("div.description.floatClear p").text
  	rescue NoMethodError
  		"N/A"
  	end  
  end

  def beds
  	begin
      @beds ||= self.doc.css("div.description.floatClear ul")[1].css("li")[1].text.match(/\d+/)[0]
    rescue NoMethodError
    	"N/A"
    end  
  end

  def baths
  	begin
  	  @baths ||= self.doc.css("div.description.floatClear ul")[1].css("li")[2].text.match(/\d+/)[0]
  	rescue NoMethodError
  		"N/A"
  	end  
  end

  def year_built
  	begin
      @year_built ||= self.doc.css("div.description.floatClear ul")[0].css("li")[1].text.match(/\d+/)[0]
    rescue NoMethodError 
    	"N/A"
    end  
  end

  def contact_info
  	begin
  	  @contact_info ||= self.doc.css("div.requiredContactInformation div.contactDetails div[itemprop='telephone']").text
    rescue NoMethodError
    	"N/A"
    end
  end

  def last_transaction
  	begin
  	  @last_transaction ||= self.doc.css("div[data-tab-name='publicFacts'] div.attributes dl")[2].css("dd").text.strip
    rescue NoMethodError
    	"N/A"
    end	
  end

  def last_transaction_purchase_price
  	begin
      @last_transaction_purchase_price ||= self.doc.css("div[data-tab-name='publicFacts'] div.attributes dl")[3].css("dd").text.strip
    rescue NoMethodError
    	"N/A"
    end    
  end

  def self.input_evaluation(index)	     
	  @@properties_types[index.to_i-1]
	end

end