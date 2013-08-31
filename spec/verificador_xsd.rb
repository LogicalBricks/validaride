require 'spec_helper'
require_relative '../models/verificador_xsd'

describe VerificadorXsd do
  it "no regresa errores si se valida un xml con datos válido versión 1.1" do
    path = File.dirname(__FILE__) + '/files/mensual_datos_1_1.xml'
    VerificadorXsd.new.verificar(path).should be_true
  end

  it "no regresa errores si se valida un xml en ceros válido versión 1.1" do
    path = File.dirname(__FILE__) + '/files/mensual_ceros_1_1.xml'
    VerificadorXsd.new.verificar(path).should be_true
  end

  it "no regresa errores si se valida un xml con datos válido versión 2.0" do
    path = File.dirname(__FILE__) + '/files/mensual_datos_2_0.xml'
    VerificadorXsd.new.verificar(path).should be_true
  end

  it "no regresa errores si se valida un xml en ceros válido versión 2.0" do
    path = File.dirname(__FILE__) + '/files/mensual_ceros_2_0.xml'
    VerificadorXsd.new.verificar(path).should be_true
  end
end
