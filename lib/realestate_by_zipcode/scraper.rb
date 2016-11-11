class RealestateByZipcode::Scraper
  
  attr_accessor :zipcode, :property_style 

  def initialize(zipcode, property_style)
  	
  	@zipcode = zipcode
  	@property_style = property_style
  	
  end

end