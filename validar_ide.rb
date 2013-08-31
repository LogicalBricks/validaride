class ValidarIde < Sinatra::Base
  register Sinatra::AssetPack

  assets do
    serve '/js', from: 'app/javascripts'
    serve '/css', from: 'app/stylesheets'
    js :appĺication, [
      '/js/*.js',
      '/js/vendor/*.js',
      '/js/foundation/*.js'
     ]

    css :application, [
      '/css/app.css',
    ]

    js_compression :jsmin
    css_compression :sass
  end


  get '/' do
    haml :index, format: :html5
  end

  post '/' do

  end
end
