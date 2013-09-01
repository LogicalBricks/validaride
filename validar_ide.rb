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
  end

  get '/' do
    haml :index, format: :html5
  end

  post '/' do
    email, file, @errors = process_post_data
    # file info in file[:tempfile]
    unless @errors.any?
      # reemplazar la siguiente línea por el llamado correcto
      if Random.rand(0..1) == 1
        @info = "El archivo ha sido procesado exitosamente. Un correo electrónico será enviado a #{email}."
      else
        @errors << 'Error al procesar el archivo XML.'
      end
    end
    haml :index, format: :html5
  end
end
