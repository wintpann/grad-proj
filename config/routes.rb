Rails.application.routes.draw do
  root 'pages#home'

  resources :users, except: :new
  get 'signup' => 'users#new'
  get 'inusers' => 'users#inactive'

  post 'login' => 'sessions#create'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :suppliers
  get 'insuppliers' => 'suppliers#inactive'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
