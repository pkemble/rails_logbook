Rails.application.routes.draw do

  resources :entries do
    resources :flights
  end
  get 'next_entry' => 'entries#next_entry'
  
  resources :flights
	get 'search_apt', to: 'flights#search_apt'
  resources :aircraft
  resources :airports 
	get 'full/search_apt', to: 'airports#search_apt'
	resources :totals

  get 'logbook/index'
  
  get 'io' => 'import_export#index'
  get 'exportJson' => 'import_export#export'
  #get 'psi_expense_report/:month', to: 'import_export#psi_expense'
  get 'psi_import' => 'import_export#psi_import'
  post 'psi_import' => 'import_export#upload'
  get 'import_loaded_csv' => 'import_export#import_loaded_csv'
  get 'delete_psi_imports' => 'import_export#delete_psi_imports'
  get 'import_pre_astro_csv' => 'import_export#upload_pre_astro'
  get 'wipe_all' => 'import_export#wipe_all'
  post 'glob_flights' => 'tools#glob_flights'
  post 'import_airports' => 'import_export#import_airports'
  get 'missing_data' => 'airports#missing_data'
  
  get 'print' => 'logbook#print'

  get 'tools' => 'tools#index'
  get 'tools_night_report' => 'tools#night_report'
  get 'tools_add_night' => 'tools#add_night'
  post 'add_night_to_single_flight' => 'tools#add_night_to_single_flight'
  get 'tools_calculate_xc' => 'tools#calculate_xc'
  post 'add_xc_to_single_flight' => 'tools#add_xc_to_single_flight'
  get 'tools_repopulate_usage' => 'tools#repopulate_usage'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'logbook#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  
  resources :users
  
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'admin'   => 'users#admin'
  
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