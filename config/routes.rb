  Rails.application.routes.draw do
  root "parkings#index"

  scope "(:locale)", locale: /en|pl/ do
    resources :parkings do
      resources :place_rents, only: [:new, :create]
    end
  end

  resources :cars
  resources :place_rents, only: [:show, :index]
  resources :accounts
  
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  get '/auth/:provider/callback', :to => 'sessions#create'
  get 'auth/failure', :to => 'sessions#failure'
  delete '/logout', to: 'sessions#destroy'
  get '/register', to: 'accounts#new', as: :register
end
