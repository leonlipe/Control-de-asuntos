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
       ["(upper(nombresolicitante) like upper(?) or nombresolicitante is null) and (upper(organizacion) like upper(?) or organizacion is null) and (upper(asunto) like upper(?) or asunto is null) and prioridad_id like ? and (categoria_id like ? or categoria_id is null) and (status_id like ? or status_id is null)", 
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
  
  def verxls
   e = Excel::Workbook.new
      asuntos = Asunto.all(:conditions =>
       ["(upper(nombresolicitante) like upper(?) or nombresolicitante is null) and (upper(organizacion) like upper(?) or organizacion is null) and (upper(asunto) like upper(?) or asunto is null) and prioridad_id like ? and (categoria_id like ? or categoria_id is null) and (status_id like ? or status_id is null)", 
         "%#{params[:nombresolicitante]}%", "%#{params[:organizacion]}%", "%#{params[:asunto]}%", "%#{params[:prioridad]}%", "%#{params[:categoria]}%", "%#{params[:status]}%" ])
       array = Array.new
          for asunto in asuntos
            item = Hash.new
            item["Fecha"] = asunto.fecha
            item["Nombre del solicitanet"] = asunto.nombresolicitante
            item["Organizacion"] = asunto.organizacion
            item["Asunto"] = asunto.asunto
            item["Descripcion"] = asunto.descripcion
            item["Telefono"] = asunto.telefono
            item["Observaciones"] = asunto.observaciones
            item["Atendido por"] = asunto.personaatendio
            item["Turnado a"] = asunto.personaturnado
            item["Prioridad"] = asunto.prioridaddesc
            item["Categoria"] = asunto.categoriadesc
            item["Fecha del ultimo contacto"] = asunto.fechaultcont
            item["Fecha del siguiente contacto"] = asunto.fechasigcont
            item["Status"] = asunto.status.tipo
            item["Audiencia publica"] =  (asunto.audienciapub ? "SI": "NO")
            item["CC Gobernador"] =  (asunto.gober ? "SI": "NO")
            array << item
          end  
       e.addWorksheetFromArrayOfHashes "Asuntos", array
       headers['Content-Type'] = "application/vnd.ms-excel"
       
       render :text=> e.build
  end
end
