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
    @allowed = Asunto::Max_Attachments - @asunto.adjuntos.count
  end

  # POST /asuntos
  # POST /asuntos.xml
  def create
    @asunto = Asunto.new(params[:asunto])
    process_file_uploads(@asunto)
    
    Asunto.transaction do
    respond_to do |format|
      if @asunto.save
        insertar_historial(@asunto)    
        
        format.html { redirect_to(@asunto, :notice => 'Asunto was successfully created.') }
        format.xml  { render :xml => @asunto, :status => :created, :location => @asunto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asunto.errors, :status => :unprocessable_entity }
      end
    end
      
    end
  end

  # PUT /asuntos/1
  # PUT /asuntos/1.xml
  def update
    @asunto = Asunto.find(params[:id])
    
    process_file_uploads(@asunto)
    
    
    respond_to do |format|
      Asunto.transaction do 
      asunto_old = @asunto.clone
      if @asunto.update_attributes(params[:asunto])
        actualizar_historial(@asunto, asunto_old)    
        format.html { redirect_to(@asunto, :notice => 'Asunto was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asunto.errors, :status => :unprocessable_entity }
      end
    end
    end
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
   
   def insertar_historial(asunto_new)
     movimiento = Movimiento.new
     movimiento.user = current_user
     movimiento.asunto = asunto_new
     movimiento.nombre_actual = asunto_new.personaturnado
     movimiento.status_actual_id = asunto_new.status.id
     movimiento.save
   end
   
   def actualizar_historial(asunto_new, asunto_old)
      movimiento = Movimiento.new
      movimiento.user = current_user
      movimiento.asunto = asunto_new
      movimiento.nombre_anterior = asunto_old.personaturnado
      movimiento.nombre_actual = asunto_new.personaturnado
      movimiento.status_anterior_id = asunto_old.status.id
      movimiento.status_actual_id = asunto_new.status.id
      if ((movimiento.nombre_anterior != movimiento.nombre_actual) || 
        (movimiento.status_anterior_id != movimiento.status_actual_id))
        movimiento.save
      end
    end
    
    def process_file_uploads(task)
        i = 0
        while params[:attachment]['file_'+i.to_s] != "" && !params[:attachment]['file_'+i.to_s].nil?
            task.adjuntos.build(:adjunto => params[:attachment]['file_'+i.to_s])
            i += 1
        end
    end
  
end
