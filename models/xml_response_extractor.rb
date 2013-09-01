require 'nokogiri'
require 'pry'

class XmlResponseExtractor
  # Xml tags
  ACUSE_RECEPCION_MENSUAL_TAG = 'AcuseRecepcionMensualIDE'
  ACUSE_RECEPCION_ANUAL_TAG = 'AcuseRecepcionAnualIDE'
  ACUSE_RECHAZO_MENSAUL_TAG = 'AcuseRechazoMensualIDE'
  ACUSE_RECHAZO_ANUAL_TAG = 'AcuseRechazoAnualIDE'

  # tipos de acuses
  ACEPTACION_ANUAL = 'aceptacion_anual'
  ACEPTACION_MENSUAL = 'aceptacion_mensual'
  RECHAZO_ANUAL = 'rechazo_anual'
  RECHAZO_MENSUAL = 'rechazo_mensual'

  attr_reader :version, :rfc, :denominacion, :fecha_presentacion, :folio_recepcion, :numero_operacion,
    :archivo_declaracion, :longitud_archivo_declaracion, :ejercicio, :periodo, :tipo, :total_recaudado,
    :total_enterado, :sello, :fecha_rechazo, :codigo_error, :mensaje_error

  def initialize(xml)
    @xml = xml
    @acuse = es_archivo_de_acuse?
    load_xml if acuse?
  end

  def acuse?
    @acuse
  end

  def aceptacion?
    @aceptacion
  end

  def rechazo?
    not aceptacion?
  end

  def anual?
    @anual
  end

  def mensual?
    @mensual
  end

  ########
  private
  #######

  # Parsea el archivo xml del acuse
  def load_xml
    case tipo_de_acuse?
    when ACEPTACION_ANUAL then load_aceptacion_anual
    when ACEPTACION_MENSUAL then load_aceptacion_mensual
    when RECHAZO_ANUAL then load_rechazo_anual
    when RECHAZO_MENSUAL then load_rechazo_mensual
    else
     raise 'No es ningún tipo de acuse conocido.'
    end
    return true
  rescue Exception => e
    puts e.message
    return false
  end

  def es_archivo_de_acuse?
    return ( tiene_tag?(ACUSE_RECEPCION_MENSUAL_TAG) or tiene_tag?(ACUSE_RECEPCION_ANUAL_TAG) or
      tiene_tag?(ACUSE_RECHAZO_MENSAUL_TAG) or tiene_tag?(ACUSE_RECHAZO_ANUAL_TAG) )
  end

  def tiene_tag?(tag)
    return @xml.css(tag).size > 0
  end

  def tipo_de_acuse?
    return ACEPTACION_ANUAL if tiene_tag?(ACUSE_RECEPCION_ANUAL_TAG)
    return ACEPTACION_MENSUAL if tiene_tag?(ACUSE_RECEPCION_MENSUAL_TAG)
    return RECHAZO_MENSUAL if tiene_tag?(ACUSE_RECHAZO_MENSAUL_TAG)
    return RECHAZO_ANUAL if tiene_tag?(ACUSE_RECHAZO_ANUAL_TAG)
    return ''
  end

  # Carga desde el archivo xml los datos comunes
  # a un archivo de aceptación
  def load_aceptacion aceptacion_tag, &block
    @aceptacion = true
    current_tag = load_tag(aceptacion_tag)
    @version = current_tag[:version]
    @rfc = current_tag[:rfc]
    @denominacion = current_tag[:denominacion]
    @fecha_presentacion = current_tag[:fechaPresentacion ]
    @folio_recepcion = current_tag[:folioRecepcion]
    @numero_operacion = current_tag[:numeroOperacion]
    @archivo_declaracion = current_tag[:nombreArchivo]
    @longitud_archivo_declaracion = current_tag[:tamanoArchivo]
    @ejercicio = current_tag[:ejercicio]
    @tipo = current_tag[:tipo]
    @total_recaudado = current_tag[:totalRecaudado]
    @sello = current_tag[:sello]
    yield current_tag if block
  end

  # Carga los datos para un archivo de aceptación mensual
  def load_aceptacion_mensual
    load_aceptacion(ACUSE_RECEPCION_MENSUAL_TAG) do |tag|
      # cargar datos adicionales desde tag
      @periodo = tag[:periodo]
      @total_enterado = tag[:totalEnterado ]
    end
    @mensual = true
  end

  # carga los datos para un archivo de aceptación anual
  def load_aceptacion_anual
    load_aceptacion ACUSE_RECEPCION_ANUAL_TAG
    @anual = true
  end

  def load_rechazo rechazo_tag
    @aceptacion = false
    tag = load_tag(rechazo_tag)
    @version = tag[:version]
    @fecha_presentacion = tag[:fechaPresentacion ]
    @fecha_rechazo = tag[:fechaRechazo]
    @archivo_declaracion = tag[:nombreArchivo]
    @longitud_archivo_declaracion = tag[:tamanoArchivo]
    error_tag = load_tag('Error')
    @codigo_error = error_tag[:clave]
    @mensaje_error = error_tag[:descripcion]
  end

  def load_rechazo_anual
    load_rechazo ACUSE_RECHAZO_ANUAL_TAG
    @anual = true
  end

  def load_rechazo_mensual
    load_rechazo ACUSE_RECHAZO_MENSAUL_TAG
    @mensual = true
  end

  def load_tag(tag)
    @xml.css(tag)[0]
  end

end # class
