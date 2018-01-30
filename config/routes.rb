Rails.application.routes.draw do

  root 'api#validate'
  get 'home_page/welcome'
  post 'api/get_course', to: 'api#get_course_id'
end
