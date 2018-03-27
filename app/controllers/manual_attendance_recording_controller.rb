# controller is responsible for handling attendance recording
# when the user record attendance thorugh the web interface
class ManualAttendanceRecordingController < ApplicationController
  # redirects if the user tries to access non-existing
  # database record by specifying url parameter manually
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_if_not_found
  # only authenticated users (both staff and student demonstrators)
  # can access all the methods defined below
  before_action :authenticate_user!
  # simple students and staff without any courses are 
  # prevented from accessing these methods
  before_action :is_staff_for_practical?
  
  
  # due to the is_staff_for_practical? before_action we know that the users who reach this action have practical(s)
  # but we still need to check whether they have any practicals at the moment
  # current_practicals_for_course_coordinator and current_practicals_for_demonstrator(id) methods are inherited from application controller
  def index
    if session[:user_type] == "staff_course_coordinator" #since staff is course coordinator, it is already checked that current_staff.courses is not empty
      @current_practicals = current_practicals_for_course_coordinator
    elsif session[:user_type] == "staff_course_coordinator_and_demonstrator"
      @current_practicals = current_practicals_for_course_coordinator.concat(current_practicals_for_demonstrator(current_staff.sam_staff_id))
    elsif session[:user_type] == "staff_demonstrator"
      @current_practicals = current_practicals_for_demonstrator(current_staff.sam_staff_id)
    elsif session[:user_type] == "student_demonstrator"
      @current_practicals = current_practicals_for_demonstrator(current_student.sam_student_id)
    else
      redirect_to dashboard_path
    end
    # if the user does not have any current practicals
    # they are redirected to the dashboard and
    # a meaningful warning message is displayed
    if @current_practicals.empty?
      flash[:warning] = "You don't have any practicals at the moment!"
      redirect_to dashboard_path
    end

  end
  
  # after the user submitted a student ID for attendance recording, 
  #this method is called
  def search
    @practical_id = params[:practical_id]
    @sam_student_id = params[:sam_student_id]
    @course_id = params[:course_id]
    # verifies that each necessary parameter is submitted
    if @sam_student_id != "" && @course_id != ""
      @student = Student.find_by(sam_student_id: @sam_student_id)
      # if student ID is not found in the database,
      # set error message and redirect
      if @student.nil?
        flash[:alert] = "Invalid student ID has been submitted"
        redirect_to record_path
      else
        # if student is in the correct practical, set course
        # otherwise, the student wants to record attendance in a wrong practical,
        # set error message and redirect
        if !Enrolment.where('student_id = ? AND course_id = ?', @student.id, @course_id).empty?
          @course = Course.find(@course_id)
        else
          flash[:alert] = "Student has not been enrolled to this course"
          redirect_to record_path
        end
      end
    # if the submitted ID field is empty, set error message and redirect
    else
      flash[:alert] = "Empty search has been submitted!"
      redirect_to record_path
    end
  end
  
  # updating the attendance table of the database by the appropriate new entry
  def attendance_recording
    # verifies that each necessary parameter is submitted
    if params[:practical_id] != "" && params[:student_id]
      # if the same attendance entry does not exist, it is going to be inserted
      if Attendance.where('student_id = ? AND practical_id = ?', params[:student_id], params[:practical_id]).empty?
        Attendance.create!(student_id: params[:student_id], practical_id: params[:practical_id])
        # sets notification/feedback message and redirets
        flash[:notice] = "Attendance is recorded successfully for student with ID: #{params[:sam_student_id]}"
        redirect_to record_path
      # if the attendance have been already recorded, sets alert message and redirects
      else 
        flash[:alert] = "Attendance is already recorded for student with ID: #{params[:sam_student_id]}"
        redirect_to record_path
      end
    # if not all the necessary paramaters are submitted, sets error message and redirects
    else
      flash[:alert] = "Attendance with invalid details has not been recorded"
      redirect_to record_path
    end
  end
  
end
