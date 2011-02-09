ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resource :session
  map.resources :adjuntos

  map.resources :asuntos do |asuntos|
   asuntos.resources :comentarios, :adjuntos
  end
  
  map.resources :historial, :only => [:index, :show]
  
  map.reporte '/reporte', :controller => 'reporte', :action => 'index'
  map.reporte '/reporte/afecha', :controller => 'reporte', :action => 'afecha'
  map.reporte '/reporte/asuntos/estado', :controller => 'reporte', :action => 'asuntoestado'
  map.reporte '/reporte/afecha/ver', :controller => 'reporte', :action => 'ver'
  map.reporte '/reporte/asuntos/estado/ver/:reporte/:asunto', :controller => 'reporte', :action => 'ver'
  map.reporte '/reporte/usuarios', :controller => 'reporte', :action => 'usuarios'
  map.reporte '/reporte/multi', :controller => 'reporte', :action => 'multi'
  map.reporte '/reporte/multi/ver', :controller => 'reporte', :action => 'ver'
  map.reporte '/reporte/multi/ver.xls', :controller => 'reporte', :action => 'verxls'
  map.reporte '/reporte/usuarios/ver', :controller => 'reporte', :action => 'ver'
  map.reporte '/reporte/usuarios/all', :controller => 'reporte', :action => 'usuariostodos'
  map.connect '/historial/detail/:id', :controller => 'historial', :action => 'detail'
  map.mail  '/mail',  :controller => 'correo', :action => 'mailDeneme'
  
  map.connect '/asuntos/xls/:id.xls', :controller => 'asuntos', :action => 'toxls'
  
 
  
  ## Administración
  map.namespace(:admin) do |admin|
     admin.resources :statuses
     admin.resources  :categorias 
     admin.resources :prioridads
     admin.resources :roles
     admin.resources :users  
     admin.root :controller => 'dashboard', :action => 'index'
   end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  # Dashboard as the default location
  map.root :controller => 'dashboard', :action => 'index'
  
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
