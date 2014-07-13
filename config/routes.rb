Flix::Application.routes.draw do

  get "relationships/create"
  get "relationships/destroy"

  get "user_route_relationships/create"
  get "user_route_relationships/destroy"

  #get "pages/home"
  #get "pages/about"
  #get "pages/contact"
  #get "users/new"

  root to: 'pages#home'

  #route per pagine statiche
  match '/about', to: 'pages#about'
  match '/faq', to: 'pages#faq'
  match '/contact', to: 'pages#contact'

  match '/signup', to: 'users#new'

  match '/signin', to: 'sessions#new'
  # signout tramite richiesta  HTTP DELETE
  match '/signout', to: 'sessions#destroy', via: :delete

  #per gestire le risorse messe a disp dal modello degli ut e dal suo controllore
  #resources :users

  # routes for the Users controller (default plus following and followers)
  resources :users do
     member do
       get :following, :followers, :messages # per esempio: get /users/1/followers
     end
  end

  # per gestione itinerari
  resources :routes do
    member do
      get :followers # per esempio: get /routes/1/followers
    end
  end

  # per gestire risorse session (solo new, create and destroy)
  resources :sessions, only: [:new, :create, :destroy]

  # default routes per il Posts controller (solo create e destroy - le altre operaz tramite Users controller)
  resources :posts, only: [:create, :destroy]

  # default routes per il Relationship controller (solo create e destroy -  necessari per costruire relaz follow/unfollow )
  resources :relationships, only: [:create, :destroy]

  # default routes per il UserRouteRelationship controller (solo create e destroy -  necessari per costruire relaz follow/unfollow )
  resources :user_route_relationships, only: [:create, :destroy]

  # default routes per il Messages controller (solo create e destroy - le altre operaz tramite Users controller)
  resources :messages, only: [:new, :create, :destroy]

  # default routes per il CommentRoute controller (solo create e destroy - le altre operaz tramite Route controller)
  resources :comment_routes, only: [:create, :destroy]

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
