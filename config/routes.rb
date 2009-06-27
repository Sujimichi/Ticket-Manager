ActionController::Routing::Routes.draw do |map|
  map.resources :change_logs


  map.active_tickets 'projects/:project_id/active', :controller => 'tickets', :action => 'index', :ticket_type => :active
  map.closed_tickets 'projects/:project_id/closed', :controller => 'tickets', :action => 'index', :ticket_type => :closed
  map.on_hold_tickets 'projects/:project_id/on_hold', :controller => 'tickets', :action => 'index', :ticket_type => :on_hold
  map.invalid_tickets 'projects/:project_id/invalid', :controller => 'tickets', :action => 'index', :ticket_type => :invalid

  map.connect 'tickets/close_ticket', :controller => 'tickets', :action => 'close_ticket'
  map.connect 'tickets/open_ticket', :controller => 'tickets', :action => 'open_ticket'
  map.connect 'tickets/hold_ticket', :controller => 'tickets', :action => 'hold_ticket'
  map.connect 'tickets/invalidate_ticket', :controller => 'tickets', :action => 'invalidate_ticket'
  map.connect 'tickets/change_priority', :controller => 'tickets', :action => 'change_priority'
  map.connect 'tickets/change_status', :controller => 'tickets', :action => 'change_status'

  map.connect 'comments/remote_destroy', :controller => 'comments', :action => 'destroy'
  
  
  map.resources :projects, :has_many => [:tickets]
  map.resources :tickets
  map.resources :comments
  map.resources :users
  map.resources :user_sessions
  map.connect 'project_users/user_request', :controller => 'project_users', :action => 'user_request'
  map.connect 'project_users/:id/accept', :controller => 'project_users', :action => 'accept'
  map.connect 'project_users/:id/reject', :controller => 'project_users', :action => 'reject'  


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
  map.root :controller => "welcome"
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.register "register", :controller => "users", :action => "new"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
