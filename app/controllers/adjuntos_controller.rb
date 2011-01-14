class AdjuntosController < ApplicationController
  def show
    @adjunto = Adjunto.find(params[:id])
    send_data @adjunto.datos, :nombrearchivo => @adjunto.nombrearchivo, :tipo => @adjunto.tipo_contenido
  end

  def create
 return if params[:adjunto].blank?

        @adjunto = Adjunto.new
        @adjunto.uploaded_file = params[:adjunto]

        if @adjunto.save
            flash[:notice] = "Gracias por subir el archivo"
            redirect_to :action => "index"
        else
            flash[:error] = "Hay un problema con el archivo"
            render :action => "new"
        end
end

end
