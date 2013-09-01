require 'spec_helper'
require_relative '../models/validador_nueva_version'

describe ValidadorNuevaVersion do
  context '.validar' do
    context 'mensual' do
      it 'atrasada versión 1.1' do
        declaracion = double('declaracion', periodo: 1, ejercicio: 2013, version: '1.1', 'mensual?' => true)
        expect(ValidadorNuevaVersion.validar(declaracion)).to eq(true)
      end

      it 'atrasada versión 2.0' do
        declaracion = double('declaracion', periodo: 1, ejercicio: 2012, version: '2.0', 'mensual?' => true)
        expect(ValidadorNuevaVersion.validar(declaracion)).to eq(true)
      end

      it 'nueva versión 2.0' do
        declaracion = double('declaracion', periodo: 10, ejercicio: 2013, version: '2.0', 'mensual?' => true)
        expect(ValidadorNuevaVersion.validar(declaracion)).to eq(true)
      end


      it 'nueva versión 1.1' do
        declaracion = double('declaracion', periodo: 10, ejercicio: 2013, version: '1.1', 'mensual?' => true)
        expect(ValidadorNuevaVersion.validar(declaracion)).to eq(false)
      end
    end

    context 'anual' do
      it 'atrasada versión 1.1' do
        declaracion = double('declaracion', ejercicio: 2013, version: '1.1', 'mensual?' => false)
        expect(ValidadorNuevaVersion.validar(declaracion)).to eq(false)
      end

      it 'atrasada versión 2.0' do
        declaracion = double('declaracion', ejercicio: 2012, version: '2.0', 'mensual?' => false)
        expect(ValidadorNuevaVersion.validar(declaracion)).to eq(true)
      end

      it 'nueva versión 2.0' do
        declaracion = double('declaracion',  ejercicio: 2014, version: '2.0', 'mensual?' => false)
        expect(ValidadorNuevaVersion.validar(declaracion)).to eq(true)
      end

      it 'nueva versión 1.1' do
        declaracion = double('declaracion', ejercicio: 2015, version: '1.1', 'mensual?' => false)
        expect(ValidadorNuevaVersion.validar(declaracion)).to eq(false)
      end
    end

  end
end

