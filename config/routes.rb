Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "generate-schedule", to: "schedules#generate_schedule"

  resources :excel_files
  root "excel_files#index"


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  resources :courses

  # Defines the root path route ("/")
  # root "posts#index"

  # For Auth0 redirects
  get '/auth/auth0/callback' => 'courses'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'
end
