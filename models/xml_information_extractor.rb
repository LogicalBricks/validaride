require 'nokogiri'

class XmlInformationExtractor
  def initialize(xml)
    @xml = xml
  end

  def total_zero?
    totales = @xml.css('Totales').first
    totales['operacionesRelacionadas'].to_i == 0 and totales['importeExcedenteDepositos'].to_i == 0
  end

  def number_of_elements
    registros = @xml.css('RegistroDeDetalle')
    registros.size
  end
end
