Rails.application.routes.draw do
  # showing classes to choose
  resources :course_classes
  resources :schedules, only: [:index, :show]
  # shows all courses
  get "/courses", to: "courses#index"
  # shows courses to choose from
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "sessions/new"
  get "sessions/create"
  get "sessions/sso_new"
  get "sessions/sso_create"
  get "users/new"
  get "users/create"
  get "home/index"
  get "generate-schedule", to: "schedules#generate_schedule"
  resources :courses
  resources :excel_files
  root "excel_files#index"
end
