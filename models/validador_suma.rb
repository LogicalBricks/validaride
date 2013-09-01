require 'nokogiri'
require 'ostruct'

class ValidadorSuma

  def initialize(xml)
    @xml = xml
  end

  def verificar_totales
    elementos = sumar_elementos
    totales = @xml.css('Totales').first
    comparar_totales(totales, elementos)
  end

  private

  def comparar_totales(totales, elementos_sumados)
    relacion_atributos = {
    'operacionesRelacionadas' => 'operacionesRelacionadas',
    'importeExcedenteDepositos' => 'montoExcedente',
    'importeDeterminadoDepositos' => 'impuestoDeterminado',
    'importeRecaudadoDepositos' => 'impuestoRecaudado',
    'importePendienteRecaudacion' => 'recaudacionPendiente',
    'importeRemanenteDepositos' => 'remanentePeriodosAnteriores',
    'importeEnterado' => 'impuestoEnterado',
    'importeCheques' => 'montoRecaudado',
    'importeSaldoPendienteRecaudar' => 'saldoPendienteRecaudar' }
    relacion_atributos.all?{ |k,v| totales[k].to_i == elementos_sumados[v] }
  end

  def sumar_elementos
    depositos = @xml.css('RegistroDeDetalle/DepositoEnEfectivo')
    enteros = @xml.css('ReporteDeRecaudacionYEnteroDiaria/EnteroPropio')
    enteros_otras_instituciones = @xml.css('ReporteDeRecaudacionYEnteroDiaria/EnteroDeOtrasInstituciones')
    cheques = @xml.css('RegistroDeDetalle/ChequeDeCaja')
    total = suma_depositos_efectivo(depositos).merge(suma_enteros(enteros + enteros_otras_instituciones)).merge(suma_cheques(cheques))
    total.merge('operacionesRelacionadas' => depositos.size)
  end

  def suma_depositos_efectivo(registros)
    atributos = %w{ montoExcedente impuestoDeterminado impuestoRecaudado recaudacionPendiente remanentePeriodosAnteriores saldoPendienteRecaudar }
    suma_registros = sumar_campos(registros, atributos)
  end

  def suma_enteros(enteros)
    atributos = %w{ impuestoEnterado }
    suma_enteros = sumar_campos(enteros, atributos)
  end

  def suma_cheques(cheques)
    atributos = %w{ montoCheque montoRecaudado }
    suma_cheques = sumar_campos(cheques, atributos)
  end

  def sumar_campos(registros, atributos)
    suma_registros = {}
    inicializa_suma_depositos_efectivo(suma_registros, atributos)
    registros.each do |registro|
      atributos.each do |atributo|
        suma_registros[atributo] += registro[atributo].to_i
      end
    end
    suma_registros
  end

  def inicializa_suma_depositos_efectivo(suma_registros, campos)
    campos.each do |campo|
      suma_registros[campo] = 0
    end
  end
end
