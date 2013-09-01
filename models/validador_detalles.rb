require 'nokogiri'

class ValidadorDetalles
  attr_reader :declaracion

  def initialize(declaracion)
    @declaracion = declaracion
  end

  def valida?
    valida_en_ceros? or valida_con_datos?
  end

  def valida_en_ceros?
    declaracion.en_ceros? and declaracion.numero_elementos == 0
  end

  def valida_con_datos?
    declaracion.con_datos? and declaracion.numero_elementos > 0
  end
end
