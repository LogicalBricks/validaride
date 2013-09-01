require 'spec_helper'
require_relative '../models/validador_detalles'

describe ValidadorDetalles do
  context 'version 1.1' do
    context 'with details' do
      context '#valida_en_ceros?' do
        it 'zeros in total with elements' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_en_ceros?).to eq(false)
        end

        it 'total > 0 without elements' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_en_ceros?).to eq(false)
        end
      end

      context '#valida_con_datos?' do
        it 'zeros in total with elements' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_con_datos?).to eq(false)
        end

        it 'total > 0 without elements' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_con_datos?).to eq(false)
        end
      end
    end

    context 'valid' do
      context '#valida_en_ceros?' do
        it 'valid zeros' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_en_ceros?).to eq(true)
        end
      end

      context '#valida_con_datos?' do
        it 'valid with data' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_1_1.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_con_datos?).to eq(true)
        end
      end
    end
  end

  context 'version 2.0' do
    context 'with details' do
      context '#valida_en_ceros?' do
        it 'zeros in total with elements' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_en_ceros?).to eq(false)
        end

        it 'total > 0 without elements' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_en_ceros?).to eq(false)
        end
      end

      context '#valida_con_datos?' do
        it 'zeros in total with elements' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_con_datos?).to eq(false)
        end

        it 'total > 0 without elements' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_con_datos?).to eq(false)
        end
      end
    end

    context 'valid' do
      context '#valida_en_ceros?' do
        it 'valid zeros' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_en_ceros?).to eq(true)
        end
      end

      context '#valida_con_datos?' do
        it 'valid with data' do
          declaracion = Declaracion.new(Nokogiri::XML(File.read('spec/files/mensual_datos_2_0.xml')))
          validator = ValidadorDetalles.new(declaracion)
          expect(validator.valida_con_datos?).to eq(true)
        end
      end
    end
  end

end
