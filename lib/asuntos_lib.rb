module AsuntosLib
  protected
  
  
  def regresa_subordinados(jefe_id , subordinados = nil, nivel = 0)
    if (subordinados.nil?)
      subordinados = Array.new
    end
    if session[:subordinados].nil?
      subordinadosQuery = User.all(:conditions => ['jefe_id = ?', jefe_id])
	  subordinadosQuery.each do | persona |
		subordinados.push(persona.id)
        regresa_subordinados(persona.id, subordinados, nivel+1)
      end
      if (nivel == 0)
        session[:subordinados] = subordinados.push(jefe_id)
      end
    end
    if (nivel == 0)
     return session[:subordinados] 
    end

  end
end