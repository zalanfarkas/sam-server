# controller is reponsible for handling homepages
class HomepagesController < ApplicationController
  # redirects if the user tries to access non-existing
  # database record by specifying url parameter manually
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_if_not_found
  # only authenticated users can access the dashboard
  before_action :authenticate_user!, only: [:dashboard]
  
  # login is the homepage for non-authenticated users
  def login
    # authenticated users cannot visit this page
    # so they are redirected to dashboard
    if current_user
      redirect_to dashboard_path
    end
  end

  # login is the homepage for authenticated users
  def dashboard
  end
end
