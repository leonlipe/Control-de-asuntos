class AdjuntosController < ApplicationController
  def show
     adjunto = Adjunto.find(params[:id])
      # do security check here
      send_file adjunto.adjunto.path, :type => adjunto.adjunto_content_type
  end

  def destroy
     adjunto = Adjunto.find(params[:id])
      @adjunto_id = adjunto.id.to_s
      @allowed = Asunto::Max_Attachments - adjunto.attachable.adjuntos.count 
      adjunto.destroy
  end

end
