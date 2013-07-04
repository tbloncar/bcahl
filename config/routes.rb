Bcahl::Application.routes.draw do

  root "pages#index"

  get "/register" => "users#new", as: :new_user
  post "/users" => "users#create", as: :users
  get "/users/:path" => "users#show", as: :user

  get "/sign-in" => "sessions#new", as: :new_session
  post "/sessions" => "sessions#create", as: :sessions
  delete "/sign-out" => "sessions#destroy", as: :session

  get "/players/new" => "players#new", as: :new_player
  post "/players" => "players#create", as: :players
  get "/players" => "players#index"
  get "/players/:path" => "players#show", as: :player
  get "/players/:path/edit" => "players#edit", as: :edit_player
  patch "/players/:path" => "players#update"
  delete "/players/:path" => "players#destroy"

  get "/teams/new" => "teams#new", as: :new_team
  post "/teams" => "teams#create", as: :teams
  get "/teams/:path" => "teams#show", as: :team
  get "/teams" => "teams#index"
  get "/teams/:path/edit" => "teams#edit", as: :edit_team
  patch "/teams/:path" => "teams#update"
  delete "/teams/:path" => "teams#destroy"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
