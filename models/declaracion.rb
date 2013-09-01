class Declaracion

  attr_reader :xml

  def initialize(xml)
    @xml = xml
  end

  def en_ceros?
    @totales_hash ||= xml.at_css('Totales')
    @totales_hash['operacionesRelacionadas'].to_i == 0 and
      @totales_hash['importeExcedenteDepositos'].to_i == 0 and
      @totales_hash['importeDeterminadoDepositos'].to_i == 0
  end

  def con_datos?
    !en_ceros?
  end

  def rfc
    @rfc ||= nodo_declaracion['rfcDeclarante']
  end

  def denominacion
    @denominacion ||= nodo_declaracion['denominacion']
  end

  def nombre
    denominacion
  end

  def numero_elementos
    @numero_elementos ||= @xml.css('RegistroDeDetalle').size
  end

  def version
    @version ||= nodo_declaracion['version']
  end

  private #========================= PRIVATE ============================== #

  def nodo_declaracion
    @declaracion_node ||= obtener_nodo_declaracion
  end

  def obtener_nodo_declaracion
    xml.at_css('DeclaracionInformativaMensualIDE') ||
      xml.at_css('DeclaracionInformativaAnualIDE')
  end
end
