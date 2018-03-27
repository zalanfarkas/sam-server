# superclass of each other controller
# contains methods used by many subclasses
class ApplicationController < ActionController::Base
  
  # generates methods such as current_user which checks
  # whether either a staff or a student is logged in
  devise_group :user, contains: [:student, :staff]
  
  # prevents Cross-site request forgery attacks
  protect_from_forgery with: :exception
  
  # sets the user type when the user signs in
  before_action :check_user_type_if_nil
  
  private
  
  # specifies user type for both user classes
  # (called after login)
  def check_user_type
    if current_student
      # student can be either a demonstrator or a simple student
      if Demonstrator.exists?(sam_demonstrator_id: current_student.sam_student_id)
        session[:user_type] = :student_demonstrator
      else 
        session[:user_type] = :student
      end
    elsif current_staff
    # staff can be course coordinator, demonstrator, 
    # both of previous ones or staff without any courses
      empty_course_list = current_staff.courses.empty?
      staff_is_demonstrator = Demonstrator.exists?(sam_demonstrator_id: current_staff.sam_staff_id)
      if empty_course_list && !staff_is_demonstrator
        session[:user_type] = :staff_without_course
      elsif empty_course_list && staff_is_demonstrator
        session[:user_type] = :staff_demonstrator
      elsif !empty_course_list && !staff_is_demonstrator
        session[:user_type] = :staff_course_coordinator
      else
        session[:user_type] = :staff_course_coordinator_and_demonstrator
      end
    else 
      session[:user_type] = nil
    end
  end
  
  # only checks user type when it is empty
  # it means checking when the user signs in
  def check_user_type_if_nil
    if current_user && session[:user_type] == nil
      check_user_type
    end
  end
  
  # checks whether the staff has course coordinator duties
  def is_course_coordinator?
    if !["staff_course_coordinator_and_demonstrator", "staff_course_coordinator"].include?(session[:user_type])
      flash[:alert] = "You are not a course organiser!"
      redirect_to dashboard_path
    end
  end
  
  # checks whether the staff is staff for practicals 
  # e.g. demonstrator or course coordinator
  def is_staff_for_practical?
    if !["staff_course_coordinator_and_demonstrator", "staff_course_coordinator", "student_demonstrator", "staff_demonstrator"].include?(session[:user_type])
      flash[:alert] = "You are not staff for any practicals!"
      redirect_to dashboard_path
    end
  end
  
  # returns current practicals of a course coordinator
  def current_practicals_for_course_coordinator
    current_time = DateTime.now
    current_practicals = []
    courses = current_staff.courses
    courses.each do |course|
      current_practicals.concat(course.practicals.where('start_time <= ? AND end_time >= ?', current_time, current_time))
    end
    return current_practicals
  end
   
  # returns current practicals of a demonstrator 
  def current_practicals_for_demonstrator(sam_id)
    current_time = DateTime.now
    return Demonstrator.find_practicals("sam_id", sam_id).where('start_time <= ? AND end_time >= ?', current_time, current_time)
  end
    
  # redirects if the user tries to access non-existing
  # database record by specifying url parameter manually
  def redirect_if_not_found
    logger.error "Attempt to access non-existent #{request.controller_class} #{params[:id]}"
    flash[:notice] = 'Sorry, but that doesn\'t exist.'
    if current_user
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end 
  
  # after signing out each user is redirected 
  # to the appropriate login page  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :staff
      new_staff_session_path
    elsif resource_or_scope == :student
      new_student_session_path
    else
      root_path
    end
  end
  
end
