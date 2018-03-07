class ApplicationController < ActionController::Base
  devise_group :user, contains: [:student, :staff]
  protect_from_forgery with: :exception
end
