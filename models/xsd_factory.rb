require 'nokogiri'

module XsdFactory
  def self.xsd(version)
    case version
    when '1.1' then Nokogiri::XML::Schema(File.read(path_xsd_1_1))
    when '2.0' then Nokogiri::XML::Schema(File.read(path_xsd_2_0))
    end
  end

  private

  def self.path_xsd_2_0
    'xsds/ide_20130430.xsd'
  end

  def self.path_xsd_1_1
    'xsds/ide_20080818.xsd'
  end
end
