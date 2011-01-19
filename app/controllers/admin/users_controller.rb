class Admin::UsersController < ApplicationController
  require_role :admin
  layout 'admin'  
    
  # DELETE /admin_users/1
  # DELETE /admin_users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.delete!

    redirect_to admin_users_path
  end

  # GET /user/1/edit
   def edit
     @user = User.find(params[:id])
   end

  # GET /admin_users
  # GET /admin_users.xml
  def index
    @users = User.paginate :all, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /admin_users/1
  # GET /admin_users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /admin_users/new
  # GET /admin_users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # POST /admin/users
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = "El usuario se creó satisfactoriamente"
        format.html { redirect_to(admin_user_url(@user)) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  


   def update
     params[:user][:role_ids] ||= []

     @user = User.find(params[:id])

     respond_to do |format|
       if @user.update_attributes(params[:user])
         format.html { redirect_to(admin_user_url(@user), :notice => 'El usuario se actualizo correctamente.') }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
       end
     end
   end
 
#  def create
#    logout_keeping_session!
#    @user = User.new(params[:user])
#    success = @user && @user.save
#    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
#      self.current_user = @user # !! now logged in
#      redirect_back_or_default('/')
#      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
#    else
#      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
#      render :action => 'new'
#    end
#  end
end
