class ReporteController < ApplicationController
  require_role :user
  
  def index
    render :layout => "lreporte"
    
  end
  
  def usuarios
    @asunto = Asunto.new
  end
    
  def ver
    usuarios = regresa_subordinados(current_user.id)
   
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
      usuarios = regresa_subordinados(current_user.id)
      @asuntos = Asunto.paginate(:page => params[:page], :per_page => 10,:conditions => ["persona_turnado_id in (?)", usuarios]) 
     
   
  end
  
  def verxls
   e = Excel::Workbook.new
   #asuntos = @asuntos 
      asuntos = Asunto.all(:conditions =>
       ["(upper(nombresolicitante) like upper(?) or nombresolicitante is null) and (upper(organizacion) like upper(?) or organizacion is null) and (upper(asunto) like upper(?) or asunto is null) and prioridad_id like ? and (categoria_id like ? or categoria_id is null) and (status_id like ? or status_id is null)", 
         "%#{params[:nombresolicitante]}%", "%#{params[:organizacion]}%", "%#{params[:asunto]}%", "%#{params[:prioridad]}%", "%#{params[:categoria]}%", "%#{params[:status]}%" ])
       array = Array.new
          for asunto in asuntos
            item = Hash.new
            item["Fecha"] = asunto.fecha if params[:asuntoform][:fecha] == "1"
            item["Nombre del solicitanet"] = asunto.nombresolicitante if params[:asuntoform][:nombresolicitante] == "1"
            item["Organizacion"] = asunto.organizacion if params[:asuntoform][:organizacion] == "1"
            item["Asunto"] = asunto.asunto if params[:asuntoform][:asunto] == "1"
            item["Descripcion"] = asunto.descripcion if params[:asuntoform][:descripcion] == "1"
            item["Telefono"] = asunto.telefono if params[:asuntoform][:telefono] == "1"
            item["Observaciones"] = asunto.observaciones if params[:asuntoform][:observaciones] == "1"
            item["Atendido por"] = asunto.personaatendio if params[:asuntoform][:persona_atendido_id] == "1"
            item["Turnado a"] = asunto.personaturnado if params[:asuntoform][:persona_turnado_id] == "1"
            item["Prioridad"] = asunto.prioridaddesc if params[:asuntoform][:prioridad_id] == "1"
            item["Categoria"] = asunto.categoriadesc if params[:asuntoform][:categoria_id] == "1"
            item["Fecha del ultimo contacto"] = asunto.fechaultcont if params[:asuntoform][:fchaultcont] == "1"
            item["Fecha del siguiente contacto"] = asunto.fechasigcont if params[:asuntoform][:fechasigcont] == "1"
            item["Status"] = asunto.status.tipo if params[:asuntoform][:status_id] == "1"
            item["Audiencia publica"] =  (asunto.audienciapub ? "SI": "NO") if params[:asuntoform][:audienciapub] == "1"
            item["CC Gobernador"] =  (asunto.gober ? "SI": "NO") if params[:asuntoform][:gober] == "1"
            array << item
          end  
       e.addWorksheetFromArrayOfHashes "Asuntos", array
       headers['Content-Type'] = "application/vnd.ms-excel"
       
       render :text=> e.build
  end
end
