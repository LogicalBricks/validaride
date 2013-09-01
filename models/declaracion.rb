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

  def anual?
    !!nodo_declaracion_anual
  end

  def mensual?
    !!nodo_declaracion_mensual
  end

  def normal?
    !!nodo_normal
  end

  def complementaria?
    !!nodo_complementaria
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

  def ejercicio
    @ejercicio ||= nodo_normal['ejercicio'] if nodo_normal
  end

  def periodo
    @periodo ||= nodo_normal_o_complementaria['periodo']
  end

  private #========================= PRIVATE ============================== #

  def nodo_declaracion
    @nodo_declaracion ||= (nodo_declaracion_anual || nodo_declaracion_mensual)
  end

  def nodo_declaracion_anual
    @nodo_declaracion_mensual ||= xml.at_css('DeclaracionInformativaAnualIDE')
  end

  def nodo_declaracion_mensual
    @nodo_declaracion_anual ||= xml.at_css('DeclaracionInformativaMensualIDE')
  end

  def nodo_normal_o_complementaria
    nodo_normal || nodo_complementaria
  end

  def nodo_normal
    @nodo_normal ||= xml.at_css('Normal')
  end

  def nodo_complementaria
    @nodo_complementaria ||= xml.at_css('Complementaria')
  end

end
