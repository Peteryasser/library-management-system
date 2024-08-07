Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resources :authors
    resources :shelves
    resources :categories
    resources :books
    resources :borrowings
    devise_for :users, controllers: {
      registrations: 'v1/users/registrations',
      sessions: 'v1/users/sessions',
      passwords: 'v1/users/passwords'

    }
    post 'users/verify_otp', to: 'users/confirmations#create'

  end 

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
