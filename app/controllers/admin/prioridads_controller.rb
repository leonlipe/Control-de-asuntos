class Admin::PrioridadsController < ApplicationController
  require_role :admin
  layout 'admin'  
  # GET /prioridads
  # GET /prioridads.xml
  def index
    @prioridads = Prioridad.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prioridads }
    end
  end

  # GET /prioridads/1
  # GET /prioridads/1.xml
  def show
    @prioridad = Prioridad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prioridad }
    end
  end

  # GET /prioridads/new
  # GET /prioridads/new.xml
  def new
    @prioridad = Prioridad.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prioridad }
    end
  end

  # GET /prioridads/1/edit
  def edit
    @prioridad = Prioridad.find(params[:id])
  end

  # POST /prioridads
  # POST /prioridads.xml
  def create
    @prioridad = Prioridad.new(params[:prioridad])

    respond_to do |format|
      if @prioridad.save
        format.html { redirect_to(admin_prioridad_url(@prioridad), :notice => 'Prioridad was successfully created.') }
        format.xml  { render :xml => @prioridad, :status => :created, :location => @prioridad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prioridad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prioridads/1
  # PUT /prioridads/1.xml
  def update
    @prioridad = Prioridad.find(params[:id])

    respond_to do |format|
      if @prioridad.update_attributes(params[:prioridad])
        format.html { redirect_to(admin_prioridad_url(@prioridad), :notice => 'Prioridad was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prioridad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prioridads/1
  # DELETE /prioridads/1.xml
  def destroy
    @prioridad = Prioridad.find(params[:id])
    @prioridad.destroy

    respond_to do |format|
      format.html { redirect_to(prioridads_url) }
      format.xml  { head :ok }
    end
  end
end
