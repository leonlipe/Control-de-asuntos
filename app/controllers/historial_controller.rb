class HistorialController < ApplicationController
  def index
     usuarios = Array.new(current_user.subordinados)
     usuarios.push(current_user)
    # @asuntos = Asunto.all(:conditions =>  ["status_id = 1", {:persona_turnado_id => current_user.subordinados }])
      #@asuntos = Asunto.all(:conditions =>  {:status_id => 1, :persona_turnado_id => current_user.subordinados })
      #@asuntos = Asunto.all
      @asuntos = Asunto.paginate(:page => params[:page], :per_page => 5,:conditions =>  { :persona_turnado_id => usuarios })
    
  end
  def show
    @asunto = Asunto.find(params[:id])
    @audits = Audit.paginate(:page => params[:page], :per_page => 5,:conditions => ["auditable_id = ?", params[:id]])
    #@movimientos = Cambio.paginate(:page => params[:page], :per_page => 5,:conditions => ["asunto_id = ?", params[:id]])
    
  end
  def detail
     @audit = Audit.find(params[:id])
   end
end
