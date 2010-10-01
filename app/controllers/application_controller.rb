# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include RoleRequirementSystem

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :prepare_for_mobile
  before_filter :consulta_pendientes
  
private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
  
  def consulta_pendientes
     if (current_user.nil?)
       usuarios = Array.new(current_user.subordinados)
       usuarios.push(current_user)
       @asuntosparavencer = Asunto.all(:conditions => ["fechasigcont > ? and fechasigcont < ? and status_id <> ? and persona_turnado_id in (?)",
                                                      (Time.now.midnight-1),(Time.now.midnight+2.day),10,usuarios])
       @asuntosvencidos = Asunto.all(:conditions => ["fechasigcont < ? and status_id <> ? and persona_turnado_id in (?)",Time.now.midnight-1,1,usuarios ])    
     end
  end

end
