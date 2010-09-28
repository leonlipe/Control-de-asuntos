class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  require_role :user
  
  def index
    usuarios = Array.new(current_user.subordinados)
    usuarios.push(current_user)
   # @asuntos = Asunto.all(:conditions =>  ["status_id = 1", {:persona_turnado_id => current_user.subordinados }])
     #@asuntos = Asunto.all(:conditions =>  {:status_id => 1, :persona_turnado_id => current_user.subordinados })
     #@asuntos = Asunto.all
     @asuntos = Asunto.all(:conditions => ["status_id <> ? and persona_turnado_id in (?)", 10, usuarios ])
     @asuntosparavencer = Asunto.all(:conditions => {:fechasigcont => (Time.now.midnight-1)..Time.now.midnight+1.day,
                                                     :status_id => 10, :persona_turnado_id => usuarios})
     @asuntosvencidos = Asunto.all(:conditions => ["fechasigcont < ? and status_id <> ? and persona_turnado_id in (?)",
       Time.now.midnight-1,1,usuarios ])
  
  end
end
