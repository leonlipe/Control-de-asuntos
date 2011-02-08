class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  require_role :user
  
  def index
    sort = case params['sort']
              when "fecha"  then "fecha"
            
              when "fecha_reverse"  then "fecha DESC"
           
              end
               
   
    @asunto = Asunto.create(params[:asunto])
    conditions = ["(fecha LIKE ? or fecha is null) and (upper(nombresolicitante) LIKE upper(?) or nombresolicitante is null) and (upper(organizacion) LIKE upper(?) or organizacion is null) and (status_id LIKE ? or status_id is null) and persona_turnado_id LIKE ? and (fechasigcont LIKE ? or fechasigcont is null)", 
      "%#{@asunto.fecha}%", "%#{@asunto.nombresolicitante}%","%#{@asunto.organizacion}%","%#{@asunto.status_id}%",  "%#{@asunto.persona_turnado_id}%","%#{@asunto.fechasigcont}%"]
               
   
    @asuntos = Asunto.paginate(:page => params[:page], :per_page => 4,:order => sort, :conditions => conditions)
    #:conditions => ["status_id <> ? and persona_turnado_id in (?)", configatron.status_terminado, usuarios ])
    if request.xml_http_request?
         render :partial => "shared/items_list", :layout => false
    end
    
   
  end
end
