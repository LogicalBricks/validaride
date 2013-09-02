require 'nokogiri'

class ValidadorNuevaVersion

  def self.validar(declaracion)
    if declaracion.mensual?
     validar_mensual(declaracion)
    else
      not ( declaracion.ejercicio.to_i >= 2013 and declaracion.version == '1.1')
    end
  end

  private

  def self.validar_mensual(declaracion)
    if declaracion.version == '1.1'
      if declaracion.ejercicio.to_i > 2013
        return false
      elsif declaracion.ejercicio.to_i == 2013
        declaracion.periodo.to_i >= 7 ? false : true
      else
        true
      end
    else
      true
    end
  end
end
