require_relative 'acuse'
require_relative 'reporte_declaracion'
require_relative 'verificador_xsd'

class ReporteGeneral
  def initialize(file_buffer)
    @xml = Nokogiri::XML( file_buffer.read() )
    # verificar si es un acuse
    @valido = ( @reporte = Acuse.new(@xml) ).acuse?
    unless @reporte.acuse?
      raise 'No es un archivo de declaración o acuse válido.' unless VerificadorXsd.validar(@xml)
      @reporte = ReporteDeclaracion.new(@xml)
    end
  rescue Exception => e
    @reporte = nil
  end

  def valido?
    @reporte != nil
  end

  def reporte
    return @reporte
  end
end # class
