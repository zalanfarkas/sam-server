Rails.application.routes.draw do
  root 'api#record_attendance'
  post 'api/get_course', to: 'api#get_course_id'
  post 'api/record_attendance', to: 'api#record_attendance'
end
