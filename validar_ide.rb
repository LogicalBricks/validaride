require_relative 'models/reporte_general'
require_relative 'models/reporte_declaracion'
require_relative 'models/acuse'
require 'date'

class ValidarIde < Sinatra::Base
  helpers Sinatra::ContentFor
  register Sinatra::AssetPack

  assets do
    serve '/js', from: 'app/javascripts'

    js :foundation, [
      '/js/vendor/*',
      '/js/foundation/foundation.js',
      '/js/foundation/foundation.*'
    ]

    js :application, [
      '/js/*'
     ]

    serve '/css', from: 'app/stylesheets'

    serve '/images', from: 'app/images'

    css :application, [
      '/css/app.css'
    ]

    serve '/fonts', from: 'app/fonts'

    js_compression :jsmin
    css_compression :sass
  end

  helpers do
    def valid_email? email
      # regexp taken from plataformatec/devise
      return (/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ =~ email) == 0
    end

    def process_post_data
      errors = []
      email = params['email']
      file = params['xml']
      errors << 'El archivo proporcionado no es un archivo XML.' unless file and file[:type] == 'text/xml'
      errors << 'El correo electrónico proporcionado no es válido.' unless valid_email? email
      [email, file, errors]
    end
    
    def send_declaracion_email email, declaracion
      @declaracion = declaracion
      Pony.mail to:         email,
                from:       'contacto@validaide.com',
                subject:    'Archivo de declaración analizado correctamente',
                html_body:  haml(:declaracion_email, layout: false)
    end

    def send_acuse_email email, acuse
      @acuse = acuse
      Pony.mail to:         email,
                from:       'contacto@validaide.com',
                subject:    'Archivo de acuse analizado correctamente',
                html_body:  haml(:acuse_email, layout: false)
    end

    def send_email email, reporte
      send_declaracion_email email, reporte if reporte.is_a? ReporteDeclaracion
      send_acuse_email email, reporte if reporte.is_a? Acuse
    end

  end

  get '/' do
    haml :index, format: :html5
  end

  post '/' do
    email, file, @errors = process_post_data
    unless @errors.any?
      reporte_general = ReporteGeneral.new(file[:tempfile])
      if reporte_general.reporte
        @info = "Tu archivo está procesado. Un correo electrónico será enviado a #{email}"
        send_email email, reporte_general.reporte
      else
        @errors << 'Tu archivo no corresponde a una declaración de IDE'
      end
    end
    haml :index, format: :html5
  end
end

# Dummy class for test purposes
class Declaracion
  attr_accessor :resultado_pruebas

  def initialize
    @resultado_pruebas = [Resultado.new('Prueba 1', true), Resultado.new('Prueba 2', false)]
  end

  def ejercicio; 2013 end
  def periodo; 'marzo' end
  def en_ceros; true end
  def con_datos; false end
  def rfc; 'LSO110121SY0' end
  def denominacion; 'Lolita Ritz SC de RL de CV' end
  def numero_elementos; 0 end
  def version; '1.1' end
  def mensual?; true end
  def en_ceros?; true end
  def normal?; true end
end

class Resultado
  attr_accessor :exito, :nombre

  def initialize nombre, exito
    @exito = exito
    @nombre = nombre
  end

  def descripcion; 'Descripción de la prueba' end
end
