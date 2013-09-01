require 'rubygems'
require 'bundler'

Bundler.require

Pony.options = {
  via: :smtp,
  from: "Valida IDE <contacto@validaide.com>"
}
 
if ENV['RACK_ENV'] == 'development'
  Pony.options.merge!({
    via: LetterOpener::DeliveryMethod,
    via_options: {location: File.expand_path('../../tmp/letter_opener', __FILE__)}
  })
end

require './validar_ide'

run ValidarIde
