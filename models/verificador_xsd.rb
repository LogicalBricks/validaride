require 'nokogiri'
require_relative 'xsd_factory'

class VerificadorXsd
  attr_reader :errores

  def verificar(xml_path)
    @xml = Nokogiri::XML(File.read(xml_path))
    @errores = validar_xsd
    @errores !~ /[^[:space:]]/
  end

  private #============== PRIVATE =================

  attr_reader :xsd, :xml

  def xsd
    @xsd ||= XsdFactory.xsd(xml_version)
  end

  def xml_version
    xml.at_xpath('//DeclaracionInformativaMensualIDE')[:version]
  end

  def validar_xsd
    xsd.validate(xml).map(&:message).join('|')
  end
end
