class HomepagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_if_not_found
  def login
  end

  def dashboard
  end
end
