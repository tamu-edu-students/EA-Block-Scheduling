Rails.application.routes.draw do

  # showing classes to choose
  resources :course_classes, only: [:index]
  resources :schedules, only: [:index, :show]
  get '/course_classes', to: 'course_classes#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Set the root path
  root 'courses#index'

  # Courses routes
  resources :courses

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
