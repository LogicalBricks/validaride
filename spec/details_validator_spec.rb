require 'spec_helper'
require_relative '../models/details_validator'

describe DetailsValidator do
  context 'version 1.1' do
    context 'with details' do
      context '#total_zero_with_zero_elements' do
        it 'zeros in total with elements' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_1_1.xml')))
          expect(validator.total_zero_with_zero_elements).to eq(false)
        end

        it 'total > 0 without elements' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_1_1.xml')))
          expect(validator.total_zero_with_zero_elements).to eq(false)
        end
      end

      context '#total_non_zero_with_elements' do
        it 'zeros in total with elements' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_1_1.xml')))
          expect(validator.total_non_zero_with_elements).to eq(false)
        end

        it 'total > 0 without elements' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_1_1.xml')))
          expect(validator.total_non_zero_with_elements).to eq(false)
        end
      end
    end

    context 'valid' do
      context '#total_zero_with_zero_elements' do
        it 'valid zeros' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_1_1.xml')))
          expect(validator.total_zero_with_zero_elements).to eq(true)
        end
      end

      context '#total_non_zero_with_elements' do
        it 'valid with data' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_datos_1_1.xml')))
          expect(validator.total_non_zero_with_elements).to eq(true)
        end
      end
    end
  end


  context 'version 2.0' do
    context 'with details' do
      context '#total_zero_with_zero_elements' do
        it 'zeros in total with elements' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_2_0.xml')))
          expect(validator.total_zero_with_zero_elements).to eq(false)
        end

        it 'total > 0 without elements' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_2_0.xml')))
          expect(validator.total_zero_with_zero_elements).to eq(false)
        end
      end

      context '#total_non_zero_with_elements' do
        it 'zeros in total with elements' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_con_detalles_2_0.xml')))
          expect(validator.total_non_zero_with_elements).to eq(false)
        end

        it 'total > 0 without elements' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_datos_sin_detalles_2_0.xml')))
          expect(validator.total_non_zero_with_elements).to eq(false)
        end
      end
    end

    context 'valid' do
      context '#total_zero_with_zero_elements' do
        it 'valid zeros' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_2_0.xml')))
          expect(validator.total_zero_with_zero_elements).to eq(true)
        end
      end

      context '#total_non_zero_with_elements' do
        it 'valid with data' do
          validator = DetailsValidator.new(Nokogiri::XML(File.read('spec/files/mensual_datos_2_0.xml')))
          expect(validator.total_non_zero_with_elements).to eq(true)
        end
      end
    end
  end

end
