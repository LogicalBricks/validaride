class ValidadorNumerosCuenta
  def self.validar(declaracion)
    @declaracion = declaracion
    !(version_2? and normal? and algun_numero_de_cuenta_por_omision?)
  end

  def self.declaracion
    @declaracion
  end

  def self.version_2?
    declaracion.version == '2.0'
  end

  def self.normal?
    declaracion.normal?
  end

  def self.algun_numero_de_cuenta_por_omision?
    declaracion.xml.css('numeroCuenta').any?{|n| n.content == '99999' }
  end
end
