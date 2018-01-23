Rails.application.routes.draw do

  root 'api#validate'
  get 'home_page/welcome'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
