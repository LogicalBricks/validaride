require 'spec_helper'
require_relative '../models/validador_numeros_cuenta'
require_relative '../models/declaracion'
require 'nokogiri'

describe ValidadorNumerosCuenta do
  it 'regresa verdadero si la declaracion es normal, version 2.0 sin cuentas por omision' do
    declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_2_0.xml')))
    expect(ValidadorNumerosCuenta.validar(declaracion)).to eq(true)
  end

  it 'regresa verdadero si la declaracion es complementaria, version 2.0 con cuentas por omision' do
    declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_2_0_complementaria.xml')))
    expect(ValidadorNumerosCuenta.validar(declaracion)).to eq(true)
  end

  it 'regresa falso si la declaracion es normal, version 2.0 con cuentas por omision' do
    declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_2_0_cuentas_omision.xml')))
    expect(ValidadorNumerosCuenta.validar(declaracion)).to eq(false)
  end

end
