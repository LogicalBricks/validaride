require 'nokogiri'

class ValidadorDetalles

  def self.validar(declaracion)
    @declaracion = declaracion
    valida_en_ceros? or valida_con_datos?
  end

  private
  def self.valida_en_ceros?
    @declaracion.en_ceros? and @declaracion.numero_elementos == 0
  end

  def self.valida_con_datos?
    @declaracion.con_datos? and @declaracion.numero_elementos > 0
  end
end
