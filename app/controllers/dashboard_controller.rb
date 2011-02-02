class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  require_role :user
  
  def index
    sort = case params['sort']
               when "Fecha"  then "fecha"  
               when "fecha_reverse"  then "fecha DESC"
               end
               
   
    @asunto = Asunto.create(params[:asunto])
    conditions = ["fecha LIKE ? and nombresolicitante LIKE ? and organizacion LIKE ? and status_id LIKE ? and persona_turnado_id LIKE ? and fechasigcont LIKE ?", 
      "%#{@asunto.fecha}%", "%#{@asunto.nombresolicitante}%","%#{@asunto.organizacion}%","%#{@asunto.status_id}%",  "%#{@asunto.persona_turnado_id}%","%#{@asunto.fechasigcont}%"]
               
   
    @asuntos = Asunto.paginate(:page => params[:page], :per_page => 10,:order => sort, :conditions => conditions)
    #:conditions => ["status_id <> ? and persona_turnado_id in (?)", configatron.status_terminado, usuarios ])
    if request.xml_http_request?
         render :partial => "shared/items_list", :layout => false
    end
    
   
  end
end
