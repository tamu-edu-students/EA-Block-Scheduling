Rails.application.routes.draw do
  get "students/dashboard"
  get "admin/dashboard"
  get "sessions/logout"
  get "sessions/omniauth"
  get "users/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "generate-schedule", to: "schedules#generate_schedule"

  resources :excel_files
  resources :courses

  # Set root to the welcome controller's index action
  root "welcome#index"

  # get user
  get "/users/:id", to: "users#show", as: "user"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA service worker and manifest routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Explicit route for welcome/index
  get "welcome/index", to: "welcome#index", as: "welcome"
  get "/logout", to: "sessions#logout", as: "logout"
  get "/auth/google_oauth2/callback", to: "sessions#omniauth"
end
