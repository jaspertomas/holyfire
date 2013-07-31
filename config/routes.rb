Holyfire::Application.routes.draw do
  resources :volunteers

  resources :participants
  post "/participants/finalize"

  resources :settings

  resources :blessings
  post "/blessings/current"
  post "/blessings/set"
  post "/blessings/addbatch"
  post "/blessings/massdeleteparticipant"
  post "/blessings/report"


  resources :batches
    #, :collection => { :massaddparticipant => :put}
  post "/batches/addparticipant"
  post "/batches/removeparticipant"
  post "/batches/massaddparticipant"
  post "/batches/massprocessparticipant"
#  post "/batches/massfinalizeparticipant"
  post "/batches/finalizeparticipant"
  post "/batches/error"
#  post "/batches/moveparticipant"

  resources :sessions, only: [:new, :create, :destroy]
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  
  resources :users  
  match '/signup', to: 'users#new'  

  get "static_pages/index"

  get "static_pages/help"

  get "static_pages/admin"

  get "static_pages/error"
  get "static_pages/adminonlyerror"
  get "static_pages/encoderonlyerror"
  get "static_pages/batcheronlyerror"

  get "static_pages/search"

  get "static_pages/initdb"
  
  root :to => 'blessings#current'  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
