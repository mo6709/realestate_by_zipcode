class RealestateByZipcode::Scraper
  #this class scrape www.homefinder.com
  attr_accessor :zipcode, :property_style, :doc 

  def initialize(zipcode, property_style)

  	@zipcode = zipcode
  	@property_style = property_style
  	
  end

	def get_homeFinder_page

		@doc = Nokogiri::HTML(open("http://www.homefinder.com/zip-code/#{@zipcode}/#{@property_style}/")) 

	end

	def scrape_homeFinder_page 

		@doc.css("div#leftColumn div.resultsBands.last")

	end

end