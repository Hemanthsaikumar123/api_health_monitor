Rails.application.routes.draw do
  resources :apis do
    resources :health_checks, only: [:index]
  end

  root "apis#index"
end