require 'spec_helper'
require_relative '../models/acuse'

describe Acuse do
  context 'con archivo inválido'

  context 'versión 1.0' do
    context 'acuse mensual' do
      context 'acuse de aceptación' do
        subject { Acuse.new(
          Nokogiri::XML(
            File.read('spec/files/acuses/acuse_recepcion_mensual_1_0.xml')
          ))}

          it { should     be_acuse }
          it { should     be_aceptacion }
          it { should_not be_rechazo }
          it { should     be_mensual }
          its(:version) { should == '1.0' }

          it 'debe extraer el RFC' do
            subject.rfc.should eq("ABC0909098A4")
          end

          it 'debe extraer la denominacion' do
            subject.denominacion.should eq("Caja de Prueba SA de CV")
          end

          it 'debe extraer la fecha de presentación de la declaración' do
            subject.fecha_presentacion.should eq("2013-07-01T14:38:25.0000000")
          end

          it 'debe extraer el folio de recepción' do
            subject.folio_recepcion.should eq("12345")
          end

          it 'debe extraer el número de operación' do
            subject.numero_operacion.should eq("67890")
          end

          it 'debe extraer el nombre del archivo de la declaración' do
            subject.archivo_declaracion.should eq("declaracion_mensual.xml")
          end

          it 'debe extraer el tamaño del archivo de la declaración' do
            subject.longitud_archivo_declaracion.should eq("1000")
          end

          it 'debe extraer el ejercicio de la declaración' do
            subject.ejercicio.should eq("2013")
          end

          it 'debe extraer el periodo de la declaración' do
            subject.periodo.should eq("6")
          end

          it 'debe extraer el tipo de la declaración' do
            subject.tipo.should eq("normal")
          end

          it 'debe extraer el total recaudado' do
            subject.total_recaudado.should eq("1200")
          end

          it 'debe extraer el total enterado' do
            subject.total_enterado.should eq("1200")
          end

          it 'debe extraer el sello digital' do
            subject.sello.should eq("rcDpRx1gu5OY+SS1eVuAVk/zE32ynRaOwnPxyJ+4jjCYuqiQd2DsDPf0eG9QJaL2PduMxgYG/eHJKLjne9dkWFHpD/uvnBQMTdYN0OPnNWyIF0XGu5p7UUvImHvd2IKJgZ4mX4FeVdl7b/fzgA0g5dLs02/EIEbZ9JLxAs+lkuk=")
          end
      end

      context 'acuse de rechazo' do
        subject { Acuse.new(
          Nokogiri::XML(
            File.read('spec/files/acuses/acuse_rechazo_mensual_malformado_1_0.xml')
          ))}

          it { should     be_rechazo }
          it { should_not be_aceptacion }
          its(:version) { should == '1.0' }

          it 'debe extraer la fecha de presentación' do
            subject.fecha_presentacion.should eq("2013-07-01T13:10:31.0000000")
          end

          it 'debe extraer la fecha de rechazo' do
            subject.fecha_rechazo.should eq("2013-07-01T13:33:21.6875000-05:00")
          end

          it 'debe extraer el nombre del archivo de la declaración' do
            subject.archivo_declaracion.should eq("declaracion_mensual.xml")
          end

          it 'debe extraer el tamaño del archivo de la declaración' do
            subject.longitud_archivo_declaracion.should eq("48")
          end

          it 'debe extraer el código de error' do
            subject.codigo_error.should eq("90")
          end

          it 'debe extraer el mensaje de error' do
            subject.mensaje_error.should eq("El archivo indicado esta mal formado: Data at the root level is invalid. Line 1, position 1.")
          end
      end # context acuse de rechazo
    end # context acuse mensual

    context 'acuse anual' do
      context 'acuse de aceptación' do
        subject { Acuse.new(
          Nokogiri::XML(
            File.read('spec/files/acuses/acuse_recepcion_anual_1_0.xml')
          ))}

          it { should     be_aceptacion }
          it { should_not be_rechazo }
          it { should     be_anual }
          its(:version) { should == '1.0' }

          it 'debe extraer el RFC' do
            subject.rfc.should eq("ABC0909098A4")
          end
          it 'debe extraer la denominacion' do
            subject.denominacion.should eq("Caja de Prueba SA de CV")
          end
          it 'debe extraer la fecha de presentación de la declaración' do
            subject.fecha_presentacion.should eq("2013-02-01T17:22:00.0000000")
          end
          it 'debe extraer el folio de recepción' do
            subject.folio_recepcion.should eq("74123")
          end
          it 'debe extraer el número de operación' do
            subject.numero_operacion.should eq("96321")
          end
          it 'debe extraer el nombre del archivo de la declaración' do
            subject.archivo_declaracion.should eq("declaracion_anual.xml")
          end
          it 'debe extraer el tamaño del archivo de la declaración' do
            subject.longitud_archivo_declaracion.should eq("1242")
          end
          it 'debe extraer el ejercicio de la declaración' do
            subject.ejercicio.should eq("2012")
          end
          it 'debe extraer el tipo de la declaración' do
            subject.tipo.should eq("normal")
          end
          it 'debe extraer el total recaudado' do
            subject.total_recaudado.should eq("12450")
          end
          it 'debe extraer el sello digital' do
            subject.sello.should eq("gEdPtiEcLwWCwyFyNRLkI8dCU7c9HSRkrdEWXKmbHZ7CvMgeWfy4y99Nj8TABwSvJw0WW9CscCj9D9/eHd/ZH4crT/KMzTLirXlhb8quIZrrPC4zfAukw9o7VjA7/b17LEp/9oLSol1n3cvUioToF50v3nh1L+7g25ZCbaFc0EY=")
          end
      end # context acuse de aceptación

      context 'acuse de rechazo' do
        subject { Acuse.new(
          Nokogiri::XML(
            File.read('spec/files/acuses/acuse_rechazo_anual_1_0.xml')
          ))}

          it { should     be_rechazo }
          it { should_not be_aceptacion }
          its(:version) { should == '1.0' }

          it 'debe extraer la fecha de presentación' do
            subject.fecha_presentacion.should eq("2013-07-01T12:25:51.0000000")
          end
          it 'debe extraer la fecha de rechazo' do
            subject.fecha_rechazo.should eq("2013-07-01T12:35:37.0625000-05:00")
          end
          it 'debe extraer el nombre del archivo de la declaración' do
            subject.archivo_declaracion.should eq("declaracion_anual.xml")
          end
          it 'debe extraer el tamaño del archivo de la declaración' do
            subject.longitud_archivo_declaracion.should eq("1242")
          end
          it 'debe extraer el código de error' do
            subject.codigo_error.should eq("90")
          end
          it 'debe extraer el mensaje de error' do
            subject.mensaje_error.should eq("The 'rfc' attribute is invalid - The value '11' is invalid according to its datatype 'String' - The Pattern constraint failed. Linea: 3 Posición linea: 29")
          end
      end
    end # context acuse anual
  end # context
end
