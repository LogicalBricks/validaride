require 'spec_helper'
require_relative '../models/declaracion'
require_relative '../models/validador_suma'

describe ValidadorSuma do
  context '#suma_valida?' do
    context 'version 2.0' do
      context 'con datos' do
        context 'válido' do
          it{ expect(ValidadorSuma.validar(Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_2_0.xml'))))).to eq(true) }
        end

        context 'inválido' do
          let(:validador){}
          it{ expect(ValidadorSuma.validar(Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_2_0.xml'))))).to eq(false) }
        end
      end

      context 'sin datos' do
        context 'válido' do
          it{ expect(ValidadorSuma.validar(Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_2_0.xml'))))).to eq(true) }
        end

        context 'inválido' do
          it{ expect(ValidadorSuma.validar(Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_2_0.xml'))))).to eq(false) }
        end
      end
    end

    context 'version 1.1' do
      context 'con datos' do
        context 'válido' do
          it{ expect(ValidadorSuma.validar(Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_1_1.xml'))))).to eq(true) }
          it{ expect(ValidadorSuma.validar(Declaracion.new(Nokogiri::XML(File.read('spec/files/anual_datos_1_1.xml'))))).to eq(true) }
        end

        context 'inválido' do
          it{ expect(ValidadorSuma.validar(Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_1_1.xml'))))).to eq(false) }
        end
      end

      context 'sin datos' do
        context 'válido' do
          it{ expect(ValidadorSuma.validar(Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_1_1.xml'))))).to eq(true) }
          it{ expect(ValidadorSuma.validar(Declaracion.new(Nokogiri::XML(File.read('spec/files/anual_ceros_1_1.xml'))))).to eq(true) }
        end

        context 'inválido' do
          it{ expect(ValidadorSuma.validar(Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_1_1.xml'))))).to eq(false) }
        end
      end
    end

  end
end
