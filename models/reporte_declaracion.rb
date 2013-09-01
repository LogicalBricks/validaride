class ReporteDeclaracion
  def initialize(xml)
    @xml = xml
    @valido = true
  end

  def valido?
    @valido
  end
end # class
