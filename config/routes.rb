Rails.application.routes.draw do
  
  get 'manual_attendance_recording/index'
  get 'manual_attendance_recording/search'
  get 'manual_attendance_recording/attendance_recording'
  get '/record', to: "manual_attendance_recording#index"
  get 'dashboard', to: 'staffs#dashboard'
  get 'remove_c6', to: 'staffs#remove_c6'
  get 'add_demonstrator', to: 'staffs#add_demonstrator'
  post 'create_demonstrator', to: 'staffs#create_demonstrator'
  get 'demonstrator_list', to: 'staffs#demonstrator_list'
  
  

  root 'static_pages#index'
  devise_for :students
  devise_for :staffs
  
  get 'static_pages/index'
  post 'api/get_course',          to: 'api#get_course_id'
  post 'api/record_attendance',   to: 'api#record_attendance'
  post 'api/pending_practicals',  to: 'api#pending_practicals'
  post 'api/upload_fingerprint',  to: 'api#upload_fingerprint'
  post 'api/current_templates',   to: 'api#current_templates'
  
  resources :students
  resources :staffs
  resources :courses
  resources :practicals
  resources :attendances
  resources :enrolments
  resources :demonstrators
  resources :pending_practicals
end
