module HistorialHelper
  
  def traduce_accion(accion)
    if (accion == "update")
      "Actualización"
    elsif (accion == "create")
      "Creación"
    end
  end

end
