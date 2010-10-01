class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  require_role :user
  
  def index
    usuarios = Array.new(current_user.subordinados)
    usuarios.push(current_user)
    @asuntos = Asunto.paginate(:page => params[:page], :per_page => 5, :conditions => ["status_id <> ? and persona_turnado_id in (?)", 10, usuarios ])

   
  end
end
