
Rails.application.routes.draw do
  # Homepage
  root "home#index"

  # Home and About pages
  get "home/index"
  get "home/about"

  # Recipe listing and recipe details
  resources :recipes, only: [:index, :show]

  # Category detail pages
  resources :categories, only: [:show]

  # Rails health check
  get "up" => "rails/health#show", as: :rails_health_check
end
