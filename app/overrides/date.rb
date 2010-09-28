require 'date'

class Date
  remove_const(:MONTHNAMES)
  MONTHNAMES = [nil] + %w(Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre)
  remove_const(:ABBR_MONTHNAMES)
  ABBR_MONTHNAMES = [nil] + %w(Ene Feb Mar Abr May Jun Jul Ago Sep Oct Nov Dic)
  remove_const(:DAYNAMES)
  DAYNAMES = %w(Domingo Lunes Martes Miercoles Jueves Viernes Sábado)
  remove_const(:ABBR_DAYNAMES)
  ABBR_DAYNAMES = %w(Dom Lun Mar Mié Jue Vie Sáb)
end

class Time
  alias :strftime_nolocale :strftime

  def strftime(format)
    format = format.dup
    format.gsub!(/%a/, Date::ABBR_DAYNAMES[self.wday])
    format.gsub!(/%A/, Date::DAYNAMES[self.wday])
    format.gsub!(/%b/, Date::ABBR_MONTHNAMES[self.mon])
    format.gsub!(/%B/, Date::MONTHNAMES[self.mon])
    self.strftime_nolocale(format)
  end
end

module ActionView
  module Helpers
    module DateHelper

      def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
        from_time = from_time.to_time if from_time.respond_to?(:to_time)
        to_time = to_time.to_time if to_time.respond_to?(:to_time)
        distance_in_minutes = (((to_time - from_time).abs)/60).round
        distance_in_seconds = ((to_time - from_time).abs).round

        case distance_in_minutes
          when 0..1
            return (distance_in_minutes == 0) ? 'menos de un minuto' : '1 minuto' unless include_seconds
            case distance_in_seconds
              when 0..4   then 'menos de 5 segundos'
              when 5..9   then 'menos de 10 segundos'
              when 10..19 then 'menos de 20 segundos'
              when 20..39 then 'medio minuto'
              when 40..59 then 'menos de un minuto'
              else             '1 minuto'
            end

          when 2..44           then "#{distance_in_minutes} minutos"
          when 45..89          then 'aprox. 1 hora'
          when 90..1439        then "aprox. #{(distance_in_minutes.to_f / 60.0).round} horas"
          when 1440..2879      then '1 día'
          when 2880..43199     then "#{(distance_in_minutes / 1440).round} días"
          when 43200..86399    then 'aprox. 1 mes'
          when 86400..525599   then "#{(distance_in_minutes / 43200).round} months"
          when 525600..1051199 then 'aprox. 1 año'
          else                      "over #{(distance_in_minutes / 525600).round} years"
        end
      end
      
    end
  end
end