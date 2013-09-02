require_relative 'declaracion'
require_relative 'validador_detalles'
require_relative 'validador_suma'
require_relative 'validador_nueva_version'
require_relative 'validador_numeros_cuenta'
require 'ostruct'

class ReporteDeclaracion
  def initialize(xml)
    @xml = xml
    @pruebas = []
    @errores = 0
    @valido  = generar_reporte(xml)
    @errores = @pruebas.reduce(0) { |sum, obj| (sum + 1) if not obj.exito } || 0
  rescue Exception => e
    puts e.message
    @valido = false
  end

  def sin_errores?
    @errores == 0
  end

  def errores
    @errores
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
    @valido = true
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
    # validar si la declaración se generó con la versión indicada
    agrega_test( 'Verificar Versión',
                'Verificar que el archivo de la declaración se haya elaborado con la versión correspondiente según lo marcado en los lineamientos del SAT',
                ValidadorNuevaVersion.validar(@declaracion)
               )
    # validar 
    agrega_test( 'Validar números de Cuenta V 2.0',
                'Valida que sea un número de cuenta válido si es una declaración normal elaborada con la versión 2.0',
                ValidadorNumerosCuenta.validar(@declaracion)
                )
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
