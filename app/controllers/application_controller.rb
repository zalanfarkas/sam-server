class ApplicationController < ActionController::Base
  devise_group :user, contains: [:student, :staff]
  protect_from_forgery with: :exception
  before_action :check_user_type_if_nil
  
  
  def check_user_type
    if current_student
      if Demonstrator.exists?(sam_demonstrator_id: current_student.sam_student_id)
        session[:user_type] = :student_demonstrator
      else 
        session[:user_type] = :student
      end
    elsif current_staff
      empty_course_list = current_staff.courses.empty?
      staff_is_demonstrator = Demonstrator.exists?(sam_demonstrator_id: current_staff.sam_staff_id)
      if empty_course_list && !staff_is_demonstrator
        session[:user_type] = :staff_without_course
      elsif empty_course_list && staff_is_demonstrator
        session[:user_type] = :staff_as_demonstrator
      elif !empty_course_list && !staff_is_demonstrator
        session[:user_type] = :staff_course_coordinator
      else
        session[:user_type] = :staff_course_coordinator_and_demonstrator
      end
    else 
      session[:user_type] = nil
    end
  end
  
  def check_user_type_if_nil
    if session[:user_type] == nil && current_user
      check_user_type
    end
  end
end
