Rails.application.routes.draw do
  
  get 'manual_attendance_recording/index'
  get 'manual_attendance_recording/search'
  get '/r', to: "manual_attendance_recording#index"

  root 'static_pages#index'
  devise_for :students
  devise_for :staffs
  
  get 'static_pages/index'
  post 'api/get_course', to: 'api#get_course_id'
  post 'api/record_attendance', to: 'api#record_attendance'
  post 'api/pending_practicals', to: 'api#pending_practicals'
  post 'api/upload_fingerprint', to: 'api#upload_fingerprint'
  
  resources :students
  resources :staffs
  resources :courses
  resources :practicals
  resources :attendances
  resources :enrolments
  resources :demonstrators
  resources :pending_practicals
end
