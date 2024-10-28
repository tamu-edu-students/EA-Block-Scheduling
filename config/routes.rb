Rails.application.routes.draw do
  # showing classes to choose
  resources :course_classes
  resources :schedules, only: [:index, :show]
  # shows all courses
  get "/courses", to: "courses#index"
  # shows courses to choose from
  get "courses/selection", to: "courses#selection"
  # shows available courses
  post "courses/available", to: "courses#available"
  get "sessions/new"
  get "sessions/create"
  get "sessions/sso_new"
  get "sessions/sso_create"
  get "users/new"
  get "users/create"
  get "home/index"
  # Landing page (main page)
  get "/home", to: "home#index", as: "home"

  get "upload/courses/:id", to: "excel_files#show_excel_data", as: :courses_by_upload_date

  # Sign-up routes
  get "/signup", to: "users#new", as: "signup"
  post "/signup", to: "users#create"

  # Login routes
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"


  # For SSO (if applicable)
  get "/sso_login", to: "sessions#sso_new", as: "sso_login"
  post "/sso_login", to: "sessions#sso_create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Set the root path


  # Schedule generation route
  get "generate-schedule", to: "schedules#generate_schedule"

  # Excel files routes
  resources :excel_files

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
