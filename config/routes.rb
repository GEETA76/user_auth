Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'posts/index'
      match 'posts', to: 'posts#index', via: [:get, :post]
      post 'register', to: 'users#create'
      post 'login', to: 'sessions#create'
    end
  end

  get 'users/new', to: 'users#new', as: 'new_user'
  post 'users', to: 'users#create'
  get 'login', to: 'users#login', as: 'login'
  post 'login', to: 'users#authenticate'
  delete 'logout', to: 'users#logout', as: 'logout'
  root 'users#new'
  resources :posts, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
