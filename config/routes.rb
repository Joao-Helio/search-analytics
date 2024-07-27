Rails.application.routes.draw do
  get 'analytics/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "searches#index"

  resources :searches, only: [:create]
  get 'search', to: 'searches#results'
  post 'searches', to: 'searches#create'
  get 'analytics', to: 'analytics#index'
end
