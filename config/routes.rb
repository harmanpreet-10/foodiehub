
Rails.application.routes.draw do
  root "home#index"

  get "home/index"
  get "home/about"

  resources :recipes, only: [:index, :show]
  resources :categories, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check
end
