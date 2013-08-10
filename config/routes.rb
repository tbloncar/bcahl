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

  post "/roster_spots" => "roster_spots#create", as: :roster_spots
  delete "/roster_spots/:id" => "roster_spots#destroy", as: :roster_spot

  get "/leagues/new" => "leagues#new", as: :new_league
  post "/leagues" => "leagues#create", as: :leagues
  get "/leagues" => "leagues#index"
  get "/leagues/:path" => "leagues#show", as: :league
  get "/leagues/:path/edit" => "leagues#edit", as: :edit_league
  patch "/leagues/:path" => "leagues#update"
  delete "/leagues/:path" => "leagues#destroy"

  get "/seasons/new" => "seasons#new", as: :new_season
  post "/seasons" => "seasons#create", as: :seasons
  get "/seasons" => "seasons#index"
  get "/leagues/:league_path/seasons/:season_path" => "seasons#show", as: :season
  get "/leagues/:league_path/seasons/:season_path/edit" => "seasons#edit", as: :edit_season
  patch "/leagues/:league_path/seasons/:season_path" => "seasons#update"
  patch "/leagues/:league_path/seasons/:season_path/activate" => "seasons#activate", as: :activate_season
  patch "/leagues/:league_path/seasons/:season_path/deactivate" => "seasons#deactivate", as: :deactivate_season
  delete "/leagues/:league_path/seasons/:season_path" => "seasons#destroy"

  post "/rosters" => "rosters#create", as: :rosters
  get "/leagues/:league_path/seasons/:season_path/rosters/:roster_path" => "rosters#show", as: :roster
  get "/leagues/:league_path/seasons/:season_path/rosters/:roster_path/edit" => "rosters#edit", as: :edit_roster
  patch "/rosters/:id" => "rosters#update"
  delete "/leagues/:league_path/seasons/:season_path/rosters/:roster_path" => "rosters#destroy"

  get "/leagues/:league_path/seasons/:season_path/games/new" => "games#new", as: :new_game
  post "/games" => "games#create", as: :games
  get "/games/:game_id" => "games#show", as: :game
  get "/games/:game_id/edit" => "games#edit", as: :edit_game
  patch "/games/:game_id" => "games#update"
  delete "/games/:game_id" => "games#destroy"

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
