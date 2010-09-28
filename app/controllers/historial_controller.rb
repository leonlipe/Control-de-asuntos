class HistorialController < ApplicationController
  def index
     usuarios = Array.new(current_user.subordinados)
     usuarios.push(current_user)
    # @asuntos = Asunto.all(:conditions =>  ["status_id = 1", {:persona_turnado_id => current_user.subordinados }])
      #@asuntos = Asunto.all(:conditions =>  {:status_id => 1, :persona_turnado_id => current_user.subordinados })
      #@asuntos = Asunto.all
      @asuntos = Asunto.all(:conditions =>  { :persona_turnado_id => usuarios })
    
  end
  def show
    @asunto = Asunto.find(params[:id])
    @movimientos = Cambio.all(:conditions => ["asunto_id = ?", params[:id]])
    
  end
end
