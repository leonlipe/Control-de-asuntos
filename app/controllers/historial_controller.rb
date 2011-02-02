class HistorialController < ApplicationController
  def index
   
    # @asuntos = Asunto.all(:conditions =>  ["status_id = 1", {:persona_turnado_id => current_user.subordinados }])
      #@asuntos = Asunto.all(:conditions =>  {:status_id => 1, :persona_turnado_id => current_user.subordinados })
      #@asuntos = Asunto.all
      @asuntos = Asunto.paginate(:page => params[:page], :per_page => 10,:conditions =>  { :persona_turnado_id => regresa_subordinados(current_user.id) })
    
  end
  def show
    @asunto = Asunto.find(params[:id])
    @audits = Audit.paginate(:page => params[:page], :per_page => 10,:conditions => ["auditable_id = ?", params[:id]])
    #@movimientos = Cambio.paginate(:page => params[:page], :per_page => 5,:conditions => ["asunto_id = ?", params[:id]])
    
  end
  def detail
     @audit = Audit.find(params[:id])
   end
end
