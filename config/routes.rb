Rails.application.routes.draw do
  root 'pages#home'

  resources :users, except: :new
  get 'signup' => 'users#new'
  get 'inusers' => 'users#inactive'
  get 'change_password' => 'users#edit_password'
  post 'change_password' => 'users#update_password'

  post 'login' => 'sessions#create'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :suppliers
  get 'insuppliers' => 'suppliers#inactive'

  resources :products
  get 'inproducts' => 'products#inactive'

  get 'arrival' => 'actions#new_arrival'
  post 'arrival' => 'actions#create_arrival'

  get 'realization' => 'actions#new_realization'
  post 'realization' => 'actions#create_realization'

  get 'write_off' => 'actions#new_write_off'
  post 'write_off' => 'actions#create_write_off'

  get 'refund' => 'actions#new_refund'
  post 'refund' => 'actions#create_refund'

  get 'warehouse' => 'actions#warehouse'

  get 'events' => 'actions#events'

  get 'invites' => 'actions#invites'
  post 'invites' => 'actions#new_invite'
  delete 'invites' => 'actions#destroy_invite'

  get 'rights' => 'actions#get_rights'
  post 'rights' => 'actions#set_rights'

  get 'event_details' => 'actions#details'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
