require 'spec_helper'
require_relative '../models/validador_suma'

describe ValidadorSuma do
  context '#suma_valida?' do
    context 'version 2.0' do
      context 'con datos' do
        context 'válido' do
          let(:validador){ValidadorSuma.new(Nokogiri::XML(File.read('spec/files/mensual_datos_2_0.xml')))}
          it{ expect(validador.verificar_totales).to eq(true) }
        end

        context 'inválido' do
          let(:validador){ValidadorSuma.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_2_0.xml')))}
          it{ expect(validador.verificar_totales).to eq(false) }
        end
      end

      context 'sin datos' do
        context 'válido' do
          let(:validador){ValidadorSuma.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_2_0.xml')))}
          it{ expect(validador.verificar_totales).to eq(true) }
        end

        context 'inválido' do
          let(:validador){ValidadorSuma.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_2_0.xml')))}
          it{ expect(validador.verificar_totales).to eq(false) }
        end
      end
    end

    context 'version 1.1' do
      context 'con datos' do
        context 'válido' do
          let(:validador){ValidadorSuma.new(Nokogiri::XML(File.read('spec/files/mensual_datos_1_1.xml')))}
          it{ expect(validador.verificar_totales).to eq(true) }
        end

        context 'inválido' do
          let(:validador){ValidadorSuma.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_1_1.xml')))}
          it{ expect(validador.verificar_totales).to eq(false) }
        end
      end

      context 'sin datos' do
        context 'válido' do
          let(:validador){ValidadorSuma.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_1_1.xml')))}
          it{ expect(validador.verificar_totales).to eq(true) }
        end

        context 'inválido' do
          let(:validador){ValidadorSuma.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_1_1.xml')))}
          it{ expect(validador.verificar_totales).to eq(false) }
        end
      end
    end

  end
end
