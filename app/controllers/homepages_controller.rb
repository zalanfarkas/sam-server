class HomepagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_if_not_found
  before_action :authenticate_user!, only: [:dashboard]
  
  def login
    if current_user
      redirect_to dashboard_path
    end
  end

  def dashboard
  end
end
