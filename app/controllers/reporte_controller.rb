class ReporteController < ApplicationController
  require_role :user
  
  def index
  end
  
  def usuarios
    @asunto = Asunto.new
  end
    
  def ver
    usuarios = Array.new(current_user.subordinados)
    usuarios.push(current_user)
    if params[:reporte] == "1" # Reporte de asuntos por usuario
      @asuntos = Asunto.all(:conditions => ["persona_turnado_id = ?", params[:persona_id]]) 
    elsif params[:reporte] == "2" # Reporte de asuntos por fecha
           @asuntos = Asunto.all(:conditions => ["fechasigcont > ? and fechasigcont < ? and persona_turnado_id in (?)", Time.parse(params[:fecha_inicial]),Time.parse(params[:fecha_final]), usuarios])
    end   
  end

  def afecha
   
  end
end
