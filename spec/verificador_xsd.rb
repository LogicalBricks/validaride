require 'spec_helper'
require_relative '../models/verificador_xsd'
require 'nokogiri'

describe VerificadorXsd do
  it "regresa verdadero si se valida un xml con datos válido versión 1.1" do
    path = File.dirname(__FILE__) + '/files/mensual_datos_1_1.xml'
    VerificadorXsd.validar(Nokogiri::XML(File.read(path))).should be_true
  end

  it "regresa verdadero si se valida un xml en ceros válido versión 1.1" do
    path = File.dirname(__FILE__) + '/files/mensual_ceros_1_1.xml'
    VerificadorXsd.validar(Nokogiri::XML(File.read(path))).should be_true
  end

  it "regresa verdadero si se valida un xml con datos válido versión 2.0" do
    path = File.dirname(__FILE__) + '/files/mensual_datos_2_0.xml'
    VerificadorXsd.validar(Nokogiri::XML(File.read(path))).should be_true
  end

  it "regresa verdadero si se valida un xml en ceros válido versión 2.0" do
    path = File.dirname(__FILE__) + '/files/mensual_ceros_2_0.xml'
    VerificadorXsd.validar(Nokogiri::XML(File.read(path))).should be_true
  end

  it "regresa falso si se valida un xml en ceros versión 1.1 que indica versión 2.0" do
    path = File.dirname(__FILE__) + '/files/mensual_ceros_1_1_indica_2_0.xml'
    VerificadorXsd.validar(Nokogiri::XML(File.read(path))).should be_false
  end

  it "regresa falso si se valida un xml en ceros versión 2.0 que indica versión 1.1" do
    path = File.dirname(__FILE__) + '/files/mensual_ceros_2_0_indica_1_1.xml'
    VerificadorXsd.validar(Nokogiri::XML(File.read(path))).should be_false
  end

  it "regresa falso si se valida un xml con datos versión 1.1 que indica versión 2.0" do
    path = File.dirname(__FILE__) + '/files/mensual_datos_1_1_indica_2_0.xml'
    VerificadorXsd.validar(Nokogiri::XML(File.read(path))).should be_false
  end

  it "regresa falso si se valida un xml en ceros versión 2.0 que indica versión 1.1" do
    path = File.dirname(__FILE__) + '/files/mensual_datos_2_0_indica_1_1.xml'
    VerificadorXsd.validar(Nokogiri::XML(File.read(path))).should be_false
  end
end
