class ComentariosController < ApplicationController
  require_role :user
  
 def create
    @asunto = Asunto.find(params[:asunto_id])
    @comentario = @asunto.comentarios.create(params[:comentario]) do |u|
      u.user = current_user
    end  

    redirect_to asunto_path(@asunto)
  end
end
