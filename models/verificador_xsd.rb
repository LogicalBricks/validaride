require_relative 'xsd_factory'

class VerificadorXsd
  def self.validar(xml)
    @xml = xml
    validar_xsd
  end

  private #============== PRIVATE =================

  def self.xml
    @xml
  end

  def self.xsd
    XsdFactory.xsd(xml_version)
  end

  def self.xml_version
    xml.at_xpath('//DeclaracionInformativaMensualIDE')[:version]
  end

  def self.validar_xsd
    xsd.validate(xml).empty?
  end
end
