class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  require_role :user
  
  def index
    usuarios = Array.new(current_user.users)
    usuarios.push(current_user)
    @asuntos = Asunto.paginate(:page => params[:page], :per_page => 5, :conditions => ["status_id <> ? and persona_turnado_id in (?)", configatron.status_terminado, usuarios ])

   
  end
end
