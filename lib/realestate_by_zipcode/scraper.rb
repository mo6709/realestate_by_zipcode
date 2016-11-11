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

	def make_properties

		scrape_homeFinder_page.each do |property|
			RealestateByZipcode::Property.new_from_index_page(property)
		end

	end

	def self.call(zipcode, property_style)

		scraper = self.new(zipcode, property_style)
    scraper.get_homeFinder_page
    scraper.scrape_homeFinder_page
    scraper.make_properties

	end

end