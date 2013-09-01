require 'spec_helper'
require_relative '../models/declaracion'
require 'nokogiri'

describe Declaracion do
  context 'version 1.1' do
    context 'con datos' do
      subject {Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_1_1.xml')))}
      it { should be_con_datos }
      it { should be_normal }
      it { should be_mensual }
      its(:numero_elementos) { should == 1 }
      its(:version) { should == "1.1" }
      its(:rfc) { should == "CAF020826YYY" }
      its(:denominacion) { should == "Caja Ficticia" }
      its(:ejercicio) { should == "2012"}
      its(:periodo) { should == "1"}
    end

    context 'en ceros' do
      subject {Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_1_1.xml')))}
      it { should be_en_ceros }
      it { should be_normal }
      it { should be_mensual }
      its(:numero_elementos) { should == 0 }
      its(:version) { should == "1.1" }
      its(:rfc) { should == "CAF020826YYY" }
      its(:denominacion) { should == "Caja Ficticia" }
      its(:ejercicio) { should == "2011"}
      its(:periodo) { should == "5"}
    end
  end

  context 'version 2.0' do
    context 'con datos' do
      subject {Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_2_0.xml')))}
      it { should be_con_datos }
      it { should be_normal }
      it { should be_mensual }
      its(:numero_elementos) { should == 3 }
      its(:version) { should == "2.0" }
      its(:rfc) { should == "AAA111111AB0" }
      its(:denominacion) { should == "Caja de Prueba S.A. de C.V." }
      its(:ejercicio) { should == "2013"}
      its(:periodo) { should == "7"}
    end

    context 'en ceros' do
      subject {Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_2_0.xml')))}
      it { should be_en_ceros }
      it { should be_normal }
      it { should be_mensual }
      its(:numero_elementos) { should == 0 }
      its(:version) { should == "2.0" }
      its(:rfc) { should == "AAA111111AB0" }
      its(:denominacion) { should == "Caja de Prueba S.A. de C.V." }
      its(:ejercicio) { should == "2013"}
      its(:periodo) { should == "7"}
    end
  end
end
