require_relative 'declaracion'
require_relative 'validador_detalles'
require_relative 'validador_suma'
require 'ostruct'

class ReporteDeclaracion
  def initialize(xml)
    @xml = xml
    @pruebas = []
    generar_reporte(xml)
  end

  def valido?
    @valido
  end

  def denominacion
    return unless @declaracion
    @declaracion.denominacion
  end

  def rfc
    return unless @declaracion
    @declaracion.rfc
  end

  def mensual?
    return unless @declaracion
    @declaracion.mensual?
  end

  def ejercicio
    return unless @declaracion
    @declaracion.ejercicio
  end

  def periodo
    return unless @declaracion
    @declaracion.periodo
  end

  def en_ceros?
    return unless @declaracion
    @declaracion.en_ceros?
  end

  def numero_elementos
    return unless @declaracion
    @declaracion.numero_elementos
  end

  def normal?
    return unless @declaracion
    @declaracion.normal?
  end

  def version
    return unless @declaracion
    @declaracion.version
  end

  def resultado_pruebas
    return @pruebas
  end

  ##########
  private
  ##########

  def generar_reporte(xml)
    @declaracion = Declaracion.new(xml)
    generar_tests
  end

  def generar_tests
    # Verificar congruencia entre totales
    detalles = agrega_test( 'Verificar Detalles',
                'Verificar que exista congruencia entre los detalles y los totales de la declaración',
                ValidadorDetalles.validar(@declaracion)
               )
    #  Si es congruente, entonces verificamos la integridad de las sumas
    agrega_test( 'Verificar Sumas',
                'Verificar la integridad de las sumas entre los detalles y los totales de la declaración',
                ValidadorSuma.validar(@declaracion)
               ) if detalles
  end

  def agrega_test(nombre, descripcion, exito)
    test = OpenStruct.new
    test.nombre = nombre
    test.descripcion = descripcion
    test.exito = exito
    @pruebas << test
    test.exito
  end
end # class
