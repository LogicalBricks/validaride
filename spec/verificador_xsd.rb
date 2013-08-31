require 'spec_helper'
require_relative '../models/verificador_xsd'

describe VerificadorXsd do
  it "no regresa errores si se valida un xml con datos válido versión 1.1" do
    path = File.dirname(__FILE__) + '/files/mensual_datos_1_1.xml'
    verificador = VerificadorXsd.new
    verificador.verificar(path).should be_true
    verificador.errores.should == ""
  end

  it "no regresa errores si se valida un xml en ceros válido versión 1.1" do
    path = File.dirname(__FILE__) + '/files/mensual_ceros_1_1.xml'
    verificador = VerificadorXsd.new
    verificador.verificar(path).should be_true
    verificador.errores.should == ""
  end

  it "no regresa errores si se valida un xml con datos válido versión 2.0" do
    path = File.dirname(__FILE__) + '/files/mensual_datos_2_0.xml'
    verificador = VerificadorXsd.new
    verificador.verificar(path).should be_true
    verificador.errores.should == ""
  end

  it "no regresa errores si se valida un xml en ceros válido versión 2.0" do
    path = File.dirname(__FILE__) + '/files/mensual_ceros_2_0.xml'
    verificador = VerificadorXsd.new
    verificador.verificar(path).should be_true
    verificador.errores.should == ""
  end

  it "regresa errores si se valida un xml en ceros versión 1.1 que indica versión 2.0" do
    path = File.dirname(__FILE__) + '/files/mensual_ceros_1_1_indica_2_0.xml'
    verificador = VerificadorXsd.new
    verificador.verificar(path).should be_false
    verificador.errores.should == "Element 'Totales': The attribute 'importeSaldoPendienteRecaudar' is required but missing."
  end

  it "regresa errores si se valida un xml en ceros versión 2.0 que indica versión 1.1" do
    path = File.dirname(__FILE__) + '/files/mensual_ceros_2_0_indica_1_1.xml'
    verificador = VerificadorXsd.new
    verificador.verificar(path).should be_false
    verificador.errores.should == "Element 'Totales', attribute 'importeSaldoPendienteRecaudar': The attribute 'importeSaldoPendienteRecaudar' is not allowed."
  end
end
