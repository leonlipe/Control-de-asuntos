# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  has_mobile_fu
  include AuthenticatedSystem
  include AsuntosLib
  include RoleRequirementSystem
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :consulta_pendientes
  
  private
  
  
  
  def consulta_pendientes
    if (!current_user.nil?)
    @asuntosvencidos = Asunto.all(:conditions => ["fechasigcont <= ? and status_id <> ? and persona_turnado_id in (?)",Time.now.midnight-1,configatron.status_terminado,regresa_subordinados(current_user.id) ])    
    end
  end
  
  def pertenece_a_mi?(usuario, usuario_propietario_id)
  usuarios = Array.new
  usuario.users.each do | user|
    usuarios.push(user.id)
  end
  return true if usuarios.include?(usuario_propietario_id) or usuario.id == usuario_propietario_id or usuario.has_role?(:admin)
  end
  
def pertenece_a_mi_o_subordinados?(usuario, subordinados, usuario_propietario_id)
  return true if subordinados.include?(usuario_propietario_id) or usuario.has_role?(:admin)
  end
  
end
