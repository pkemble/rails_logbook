Rails.application.routes.draw do

  resources :entries do
    resources :flights
  end
  resources :flights

  resources :airports

  get 'logbook/index'
  
  get 'io' => 'import_export#index'
  get 'exportJson' => 'import_export#export'
  #get 'psi_expense_report/:month', to: 'import_export#psi_expense'
  get 'psi_import' => 'import_export#psi_import'
  post 'psi_import' => 'import_export#upload'
  post 'import_loaded_csv' => 'import_export#import_loaded_csv'
  post 'reimport_psi_imports' => 'import_export#reimport_psi_imports'
  post 'import_pre_astro_csv' => 'import_export#upload_pre_astro'
  post 'glob_flights' => 'import_export#glob_flights'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'logbook#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'continued_entry' => 'entries#continued_entry'
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
