class AsuntosController < ApplicationController
  require_role :user
  
  # GET /asuntos
  # GET /asuntos.xml
  def index
    #@asuntos = Asunto.all
    #@asuntos = Asunto.paginate(:page => params[:page], :per_page => 5)

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @asuntos }
    #end
    redirect_to root_path
  end

  # GET /asuntos/1
  # GET /asuntos/1.xml
  def show
    @asunto = Asunto.find(params[:id])
  #if pertenece_a_mi_o_subordinados?(current_user,regresa_subordinados(current_user.id), @asunto.persona_turnado_id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asunto }
      format.pdf  { render :layout => false }
      
    end
   # else 
  #       redirect_to(root_path,:notice => 'No se tienen permisos.')
  #  end

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
    #if current_user.has_role?(:admin)
   @asunto = Asunto.find(params[:id])

    if pertenece_a_mi_o_subordinados?(current_user,regresa_subordinados(current_user.id), @asunto.persona_turnado_id)
      @allowed = Asunto::Max_Attachments - @asunto.adjuntos.count
    else
       redirect_to(root_path,:notice => 'No se tienen permisos.')
      
    end
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
        if (configatron.envia_email)
          UserMailer.deliver_registration_confirmation(current_user.email, "Asunto creado", "Se ha creado un asunto y ha sido asignado a su usuario, por favor verifiquelo. Asunto:"+@asunto.asunto)
        end
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
    #if current_user.has_role?(:admin)
    @asunto = Asunto.find(params[:id])
    if pertenece_a_mi_o_subordinados?(current_user,regresa_subordinados(current_user.id), @asunto.persona_turnado_id)
    
    process_file_uploads(@asunto)
    
    
    respond_to do |format|
      Asunto.transaction do 
      asunto_old = @asunto.clone
      if @asunto.update_attributes(params[:asunto])
        actualizar_historial(@asunto, asunto_old)    
         if (configatron.envia_email)
            UserMailer.deliver_registration_confirmation(current_user.email, "Asunto actualizado", "Se ha actualizado un asunto que necesita de su atencion, por favor verifiquelo. Asunto:"+@asunto.asunto)
          end
        format.html { redirect_to(@asunto, :notice => 'Asunto was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asunto.errors, :status => :unprocessable_entity }
      end
    end
    end
   else
       redirect_to(root_path,:notice => 'No se tienen permisos.')
end    
  end

  # DELETE /asuntos/1
  # DELETE /asuntos/1.xml
  def destroy
    if current_user.has_role?(:admin)
    
    @asunto = Asunto.find(params[:id])
    @asunto.destroy

    respond_to do |format|
      format.html { redirect_to(asuntos_url) }
      format.xml  { head :ok }
    end
     else
         redirect_to(root_path,:notice => 'No se tienen permisos.')
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
      if !(params[:archivo].nil?)
        logger.info params[:archivo].size
        params[:archivo].each {|arch|  task.adjuntos.build(:adjunto => arch)}
      end
    end
    
    
    def toxls
       e = Excel::Workbook.new
       asuntos = Asunto.find(:all)
       array = Array.new
          for asunto in asuntos
            item = Hash.new
            item["Fecha"] = asunto.fecha
            item["Nombre del solicitanet"] = asunto.nombresolicitante
            item["Organizacion"] = asunto.organizacion
            item["Asunto"] = asunto.asunto
            item["Descripcion"] = asunto.descripcion
            item["Telefono"] = asunto.telefono
            item["Observaciones"] = asunto.observaciones
            item["Atendido por"] = asunto.personaatendio
            item["Turnado a"] = asunto.personaturnado
            item["Prioridad"] = asunto.prioridaddesc
            item["Categoria"] = asunto.categoriadesc
            item["Fecha del ultimo contacto"] = asunto.fechaultcont
            item["Fecha del siguiente contacto"] = asunto.fechasigcont
            item["Status"] = asunto.status.tipo
            item["Audiencia publica"] =  (asunto.audienciapub ? "SI": "NO")
            item["CC Gobernador"] =  (asunto.gober ? "SI": "NO")
            array << item
          end  
       e.addWorksheetFromArrayOfHashes "Asuntos", array
       headers['Content-Type'] = "application/vnd.ms-excel"
       
       render :text=> e.build
    end
  
end
