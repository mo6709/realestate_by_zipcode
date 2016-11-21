class RealestateByZipcode::Scraper
  #this class scrape www.homefinder.com
  attr_accessor :zipcode, :property_type, :doc 

  def initialize(zipcode, property_type)
  	@zipcode = zipcode
  	@property_type = property_type	
  end

	def get_homeFinder_page
	  @doc = Nokogiri::HTML(open("http://www.homefinder.com/zip-code/#{@zipcode}/property-type-#{@property_type}/"))	     
	end

	def scrape_homeFinder_page 
		@doc.css("div#leftColumn div.resultsBands.last")
	end

	def scrape_and_create_properties
		scrape_homeFinder_page.each do |property|
		  location = property.css("span[itemprop='name']").text + property.css("div.cityStZip").text 
		  price = property.css("div.price").text.strip                                              
		  url = property.css("div.alignForTwoPhotos a").attribute("href").value 

			RealestateByZipcode::Property.new(location, price, url)
		end
	end

	def self.call(zipcode, property_style)
		scraper = self.new(zipcode, property_style)
		begin
      scraper.get_homeFinder_page
  	  scraper.scrape_homeFinder_page
      scraper.scrape_and_create_properties
    rescue OpenURI::HTTPError => error
    	error.message
    end   
	end

end