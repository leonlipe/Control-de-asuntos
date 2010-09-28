class Admin::RolesController < ApplicationController
  require_role :admin
  layout 'admin'  
  
  def index
     @users = User.paginate :all, :page => params[:page]

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @users }
      end    
  end
  
  def create
    
  end

end
