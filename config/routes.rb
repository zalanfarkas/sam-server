Rails.application.routes.draw do
  
  root 'static_pages#index'
  devise_for :students
  devise_for :staffs
  
  get 'static_pages/index'
  post 'api/get_course', to: 'api#get_course_id'
  post 'api/record_attendance', to: 'api#record_attendance'
  post 'api/pending_practicals', to: 'api#pending_practicals'
  
  resources :students
  resources :staffs
  resources :courses
  resources :practicals
  resources :attendances
  resources :enrolments
  resources :demonstrators
  resources :pending_practicals
end
