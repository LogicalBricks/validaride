require 'spec_helper'
require_relative '../models/reporte_general'

describe ReporteGeneral do
  context 'con archivo xml de declaración' do
    let(:reporte_general) { ReporteGeneral.new( File.open('spec/files/mensual_datos_1_1.xml') ) }
    it { reporte_general.reporte.should be_an_instance_of ReporteDeclaracion }
  end # context

  context 'con archivo xml de acuse' do
    let(:reporte_general) { ReporteGeneral.new( File.open('spec/files/acuses/acuse_recepcion_mensual_1_0.xml') ) }
    it { reporte_general.reporte.should be_an_instance_of Acuse }
  end # context

  context 'con archivo inválido' do
    let(:reporte_general) { ReporteGeneral.new( File.open('spec/files/some.xml') ) }
    it { reporte_general.reporte.should be_nil }
  end # context
end # describe
