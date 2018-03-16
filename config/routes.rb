Rails.application.routes.draw do
  
  root 'homepages#login'
  
  get 'homepages/login'
  get 'homepages/dashboard'
  get 'manual_attendance_recording/index'
  get 'manual_attendance_recording/search'
  post 'manual_attendance_recording/attendance_recording'
  get '/record', to: "manual_attendance_recording#index"
  get 'manage_c6s', to: 'staffs#manage_c6s'
  get 'remove_c6', to: 'staffs#remove_c6'
  get 'add_demonstrator', to: 'staffs#add_demonstrator'
  post 'create_demonstrator', to: 'staffs#create_demonstrator'
  get 'demonstrator_list', to: 'staffs#demonstrator_list'
  get 'remote', to: 'pending_practicals#new'
  get 'delete_demonstrator', to: 'staffs#delete_demonstrator'
  delete 'destroy_demonstrator', to: 'staffs#destroy_demonstrator'
  get 'practical_details', to: 'staffs#practical_details'
  get 'attendance_statistics', to: 'staffs#attendance_statistics'
  get 'attendance_statistics_for_certain_student', to: 'staffs#attendance_statistics_for_certain_student'
  get 'dashboard', to: 'homepages#dashboard'
  
  devise_for :staffs, controllers: {
        sessions: 'staffs/sessions',
        #confirmations: 'staffs/confirmations',
        passwords: 'staffs/passwords',
        #registrations: 'staffs/registrations',
        unlocks: 'staffs/unlocks'
  }
  devise_for :students, controllers: {
        sessions: 'students/sessions',
        #confirmations: 'students/confirmations',
        passwords: 'students/passwords',
        #registrations: 'students/registrations',
        unlocks: 'students/unlocks'
  }
  get 'static_pages/index'
  post 'api/get_course',          to: 'api#get_course_id'
  post 'api/record_attendance',   to: 'api#record_attendance'
  post 'api/pending_practicals',  to: 'api#pending_practicals'
  post 'api/upload_fingerprint',  to: 'api#upload_fingerprint'
  post 'api/current_templates',   to: 'api#current_templates'
  
  #resources :students
  #resources :staffs
  #resources :courses
  #resources :practicals
  #resources :attendances
  #resources :enrolments
  #resources :demonstrators
  #resources :pending_practicals
  
  get '*path' => redirect('/')
end
