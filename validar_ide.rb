class ValidarIde < Sinatra::Base
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
    css :application, [
      '/css/app.css'
    ]

    serve '/fonts', from: 'app/fonts'

    js_compression :jsmin
    css_compression :sass
  end


  get '/' do
    haml :index, format: :html5
  end

  post '/' do

  end
end
