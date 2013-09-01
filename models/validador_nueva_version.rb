require 'nokogiri'

class ValidadorNuevaVersion

  def self.validar(declaracion)
    if declaracion.mensual?
      not ( declaracion.ejercicio >= 2013 and declaracion.periodo >= 7 and declaracion.version == '1.1')
    else
      not ( declaracion.ejercicio >= 2013 and declaracion.version == '1.1')
    end
  end
end
