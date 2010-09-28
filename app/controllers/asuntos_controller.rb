class AsuntosController < ApplicationController
  require_role :user
  
  # GET /asuntos
  # GET /asuntos.xml
  def index
    #@asuntos = Asunto.all
    @asuntos = Asunto.paginate(:page => params[:page], :per_page => 5)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asuntos }
    end
  end

  # GET /asuntos/1
  # GET /asuntos/1.xml
  def show
    @asunto = Asunto.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asunto }
    end
  end

  # GET /asuntos/new
  # GET /asuntos/new.xml
  def new
    @asunto = Asunto.new
    @asunto.persona_atendio_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asunto }
    end
  end

  # GET /asuntos/1/edit
  def edit
    @asunto = Asunto.find(params[:id])
  end

  # POST /asuntos
  # POST /asuntos.xml
  def create
    @asunto = Asunto.new(params[:asunto])

    respond_to do |format|
      if @asunto.save
        format.html { redirect_to(@asunto, :notice => 'Asunto was successfully created.') }
        format.xml  { render :xml => @asunto, :status => :created, :location => @asunto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asunto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /asuntos/1
  # PUT /asuntos/1.xml
  def update
    @asunto = Asunto.find(params[:id])
    respond_to do |format|
      if @asunto.update_attributes(params[:asunto])
        if session[:movimientoasunto]=="status"
          insertar_historial("Cambio en el status", @asunto, current_user)
        elsif session[:movimientoasunto]=="turnar"
          insertar_historial("Se turnó el asunto", @asunto, current_user)
        else
          insertar_historial("Se cambió el asunto", @asunto, current_user)
          
        end
        format.html { redirect_to(@asunto, :notice => 'Asunto was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asunto.errors, :status => :unprocessable_entity }
      end
    end
  end

  def updateturnar
    insertar_historial("Cambio en el registro", @asunto, current_user)
    
  end

  # DELETE /asuntos/1
  # DELETE /asuntos/1.xml
  def destroy
    @asunto = Asunto.find(params[:id])
    @asunto.destroy

    respond_to do |format|
      format.html { redirect_to(asuntos_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /asuntos/turnar/1/edit
   def turnar
     @asunto = Asunto.find(params[:id])
     session[:movimientoasunto]="turnar"
   end
   
   # GET /asuntos/status/1/edit
     def turnar
       @asunto = Asunto.find(params[:id])
       session[:movimientoasunto]="status"
     end
   
   def insertar_historial(cambio, asunto, user)
     @cambio = Cambio.new
     @cambio.descripcion = cambio
     @cambio.user = user
     @cambio.asunto = asunto
     @cambio.save
   end
  
end
