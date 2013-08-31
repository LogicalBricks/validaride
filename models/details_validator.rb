class DetailsValidator
  def initialize(xml)
    @xml = xml
  end

  def validate_details
    self.total_zero_with_zero_elements and self.total_no_zero_with_elements
  end

  private

  def total_zero_with_zero_elements

  end
end
