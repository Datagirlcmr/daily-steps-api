Rails.application.routes.draw do
  resources :users
  resources :steps do
    resources :measurements
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  get 'profile', to: 'users#show'
  put '/edit-profile', to: 'users#update'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
