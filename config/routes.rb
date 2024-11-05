Rails.application.routes.draw do
  root "welcome#index", to: "welcome#index", as: "welcome"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "/auth/failure", to: "sessions#failure"  # Optional, for handling failed authentication
  get "/auth/google_oauth2/callback", to: "sessions#omniauth"
  get "admin/dashboard", to: "admin#dashboard", as: :admin_dashboard
  get "dashboard", to: "students#dashboard", as: :students_dashboard

  # Course and schedule routes
  resources :courses
  resources :schedules, only: [:index, :show] do
    collection do
      get "generate_schedule", to: "schedules#generate_schedule", as: :generate
    end
  end

  # User and session routes
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy] do
    collection do
      get "sso_new"
      get "sso_create"
      get "/logout", to: "sessions#logout", as: "logout"
    end
  end

  # Excel file routes
  resources :excel_files
end
