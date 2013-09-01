require 'spec_helper'
require_relative '../models/validador_detalles'

describe ValidadorDetalles do
  context 'version 1.1' do
    context 'con detalles' do
      context '#valida_en_ceros?' do
        it 'mensual en ceros con elementos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).not_to be_valida_en_ceros
        end

        it 'mensual con totales > 0 sin elementos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).not_to be_valida_en_ceros
        end
      end

      context '#valida_con_datos?' do
        it 'mensual en ceros con elementos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).not_to be_valida_en_ceros
        end

        it 'mensual con totales > 0 sin elementos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).not_to be_valida_con_datos
        end
      end
    end

    context 'valid' do
      context '#valida_en_ceros?' do
        it 'mensual válida en ceros' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).to be_valida_en_ceros
        end
        it 'anual válida en ceros' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/anual_ceros_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).to be_valida_en_ceros
        end
      end

      context '#valida_con_datos?' do
        it 'mensual válida con datos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).to be_valida_con_datos
        end
        it 'anual válida con datos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).to be_valida_con_datos
        end
      end
    end
  end

  context 'version 2.0' do
    context 'con detalles' do
      context '#valida_en_ceros?' do
        it 'mensual en ceros con elementos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).not_to be_valida_en_ceros
        end

        it 'mensual totales > 0 sin elementos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).not_to be_valida_en_ceros
        end
      end

      context '#valida_con_datos?' do
        it 'mensual en ceros con elementos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).not_to be_valida_con_datos
        end

        it 'mensual totales > 0 sin elementos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).not_to be_valida_con_datos
        end
      end
    end

    context 'válida' do
      context '#valida_en_ceros?' do
        it 'mensual válida en ceros' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).to be_valida_en_ceros
        end
      end

      context '#valida_con_datos?' do
        it 'mensual válida con datos' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator).to be_valida_con_datos
        end
      end
    end
  end

end
