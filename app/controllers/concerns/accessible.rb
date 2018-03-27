#concern to prevent cross-model visits for devise models
#logged-in staff cannot visit student login page and vica-versa
module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_staff
      flash.clear
      redirect_to(dashboard_path) && return
    elsif current_student
      flash.clear
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(dashboard_path) && return
    end
  end
end