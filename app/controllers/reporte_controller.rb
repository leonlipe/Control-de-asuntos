class ReporteController < ApplicationController
  require_role :user
  
  def index
    render :layout => "lreporte"
    
  end
  
  def usuarios
    @asunto = Asunto.new
  end
    
  def ver
    usuarios = Array.new(current_user.users)
    usuarios.push(current_user)
    if params[:reporte] == "1" # Reporte de asuntos por usuario
      @asuntos = Asunto.paginate(:page => params[:page], :per_page => 10,:conditions => ["persona_turnado_id = ?", params[:persona_id]]) 
    elsif params[:reporte] == "2" # Reporte de asuntos por fecha
      @asuntos = Asunto.paginate(:page => params[:page], :per_page => 10,:conditions => ["fechasigcont > ? and fechasigcont < ? and persona_turnado_id in (?)", Time.parse(params[:fecha_inicial]),Time.parse(params[:fecha_final]), usuarios])
    elsif params[:reporte] == "3" # Reporte de cambios de estado de asuntos
      @movimientos = Movimiento.all(:conditions => ["asunto_id = ?",params[:asunto]], :order => "created_at")
     elsif params[:reporte] == "4" # Reporte multicosas
      
      @asuntos = Asunto.paginate(:page => params[:page], :per_page => 10,:conditions =>
       ["(nombresolicitante like ? or nombresolicitante is null) and (organizacion like ? or organizacion is null) and (asunto like ? or asunto is null) and prioridad_id like ? and (categoria_id like ? or categoria_id is null) and (status_id like ? or status_id is null)", 
         "%#{params[:nombresolicitante]}%", "%#{params[:organizacion]}%", "%#{params[:asunto]}%", "%#{params[:prioridad]}%", "%#{params[:categoria]}%", "%#{params[:status]}%" ])
    end     
  end

  def afecha
   
  end
  def multi
   
  end
  def asuntoestado
      usuarios = Array.new(current_user.users)
      usuarios.push(current_user)
      @asuntos = Asunto.paginate(:page => params[:page], :per_page => 5,:conditions => ["persona_turnado_id in (?)", usuarios]) 
     
   
  end
end
