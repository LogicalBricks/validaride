require 'spec_helper'
require_relative '../models/xml_information_extractor'

describe XmlInformationExtractor do
  context 'version 1.1' do
    context 'with data' do
      let(:extractor){XmlInformationExtractor.new(Nokogiri::XML(File.read('spec/files/mensual_datos_1_1.xml')))}
      context '#total_zero?' do
        it 'with total values > 0 return false' do
          expect(extractor.total_zero?).to eq(false)
        end
      end

      context '#number_of_elements' do
        it 'should return the number of elements > 0' do
          expect(extractor.number_of_elements).to eq(1)
        end
      end
    end

    context 'without data' do
      let(:extractor){XmlInformationExtractor.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_1_1.xml')))}

      context '#total_zero?' do
        it 'with total values == 0 return true' do
          expect(extractor.total_zero?).to eq(true)
        end

        context '#number_of_elements' do
          it 'should return the number of elements == 0' do
            expect(extractor.number_of_elements).to eq(0)
          end
        end

      end
    end
  end

  context 'version 2.0' do
    context 'with data' do
      let(:extractor){XmlInformationExtractor.new(Nokogiri::XML(File.read('spec/files/mensual_datos_2_0.xml')))}
      context '#total_zero?' do
        it 'with total values > 0 return false' do
          expect(extractor.total_zero?).to eq(false)
        end
      end

      context '#number_of_elements' do
        it 'should return the number of elements > 0' do
          expect(extractor.number_of_elements).to eq(3)
        end
      end
    end

    context 'without data' do
      let(:extractor){XmlInformationExtractor.new(Nokogiri::XML(File.read('spec/files/mensual_ceros_1_1.xml')))}

      context '#total_zero?' do
        it 'with total values == 0 return true' do
          expect(extractor.total_zero?).to eq(true)
        end

        context '#number_of_elements' do
          it 'should return the number of elements == 0' do
            expect(extractor.number_of_elements).to eq(0)
          end
        end

      end
    end
  end
end
