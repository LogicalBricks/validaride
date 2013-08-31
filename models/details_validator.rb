require 'nokogiri'

class DetailsValidator
  def initialize(xml)
    @xml = xml
  end

  def valid_without_details?
    total_zero_with_zero_elements or total_no_zero_with_elements
  end

  def total_zero_with_zero_elements
    extractor = XmlInformationExtractor.new(@xml)
    extractor.total_zero? and extractor.number_of_elements == 0
  end

  def total_non_zero_with_elements
    extractor = XmlInformationExtractor.new(@xml)
    (not extractor.total_zero?) and extractor.number_of_elements > 0
  end
end
