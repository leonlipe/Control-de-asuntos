class Movimiento < ActiveRecord::Base
  belongs_to :status_anterior, :class_name => "status"
  belongs_to :status_actual, :class_name => "status"
  belongs_to :user
  belongs_to :asunto
  
  
  def usuarioanteriorname
    if (nombre_anterior.nil?)
    "NA"
  else
    nombre_anterior
  end
  end
  
  
  def usuarioactualname
      if (nombre_actual.nil?)
      "NA"
    else
    nombre_actual
  end
  end
  
  def statusanterior
    if (status_anterior_id.nil?)
      "NA"
    else  
      Status.find(status_anterior_id).tipo
    end
  end
  
  def statusactual
    if (status_actual_id.nil?)
      "NA"
    else  
      Status.find(status_actual_id).tipo
    end
  end
end
