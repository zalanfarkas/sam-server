Rails.application.routes.draw do
  root 'api#homepage'
  post 'api/get_course', to: 'api#get_course_id'
  post 'api/record_attendance', to: 'api#record_attendance'
  
  resources :students
  resources :staffs
  resources :courses
  resources :practicals
  resources :attendances
  resources :enrolments
  resources :demonstrators
end
