Bundler.require
require_relative '../validar_ide'
require File.dirname(__FILE__) + '/spec_helper'

require 'capybara'
require 'capybara/rspec'

Capybara.app = ValidarIde

RSpec.configure do |config|
  config.include Capybara
end

Pony.options = {
  # TODO: Change deliver method to something that does not open page
  via: LetterOpener::DeliveryMethod,
  via_options: {location: File.expand_path('../../tmp/letter_opener', __FILE__)},
  from: "Valida IDE <contacto@validaide.com>"
}
