class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  require_role :user
  
  def index
    sort = case params['sort']
               when "Fecha"  then "fecha"  
               when "fecha_reverse"  then "fecha DESC"
               end
    asuntoparams = Asunto.create(params[:asunto])
    conditions = ["fecha LIKE ? and nombresolicitante LIKE ? and organizacion LIKE ?", "%#{asuntoparams.fecha}%", "%#{asuntoparams.nombresolicitante}%","%#{asuntoparams.organizacion}%"]
               
   
    usuarios = Array.new(current_user.users)
    usuarios.push(current_user)
    @asuntos = Asunto.paginate(:page => params[:page], :per_page => 5,:order => sort, :conditions => conditions)
    #:conditions => ["status_id <> ? and persona_turnado_id in (?)", configatron.status_terminado, usuarios ])
    if request.xml_http_request?
         render :partial => "items_list", :layout => false
       end
   
  end
end
