Rails.application.routes.draw do
  root 'api#validate'
  post 'api/get_course', to: 'api#get_course_id'
  post 'api/record_attendance', to: 'api#record_attendance'
end
