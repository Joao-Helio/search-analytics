Rails.application.routes.draw do
  get 'analytics/index'
  get "up" => "rails/health#show", as: :rails_health_check
  root "searches#index"
  resources :searches, only: [:create]
  get 'search', to: 'searches#results'
  post 'searches', to: 'searches#create'
  get 'searches/suggestions', to: 'searches#suggestions'
  get 'analytics', to: 'searches#analytics'
end
