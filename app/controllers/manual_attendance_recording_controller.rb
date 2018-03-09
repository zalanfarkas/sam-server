class ManualAttendanceRecordingController < ApplicationController
  before_action :authenticate_user!
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
    if @current_practicals.empty?
      flash[:warning] = "You don't have any practicals at the moment!"
      redirect_to dashboard_path
    end

  end
  
  def search
    @practical_id = params[:practical_id]
    @sam_student_id = params[:sam_student_id]
    @course_id = params[:course_id]
    if @sam_student_id != "" && @course_id != ""
      @student = Student.find_by(sam_student_id: @sam_student_id)
      if @student.nil?
        flash[:alert] = "Invalid student ID has been submitted"
        redirect_to record_path
      else
        if !Enrolment.where('student_id = ? AND course_id = ?', @student.id, @course_id).empty?
          @course = Course.find(@course_id)
        else
          flash[:alert] = "Student has not been enrolled to this course"
          redirect_to record_path
        end
      end
    else
      flash[:alert] = "Empty search has been submitted!"
      redirect_to record_path
    end
  end
  
  def attendance_recording
    if params[:practical_id] != "" && params[:student_id]
      if Attendance.where('student_id = ? AND practical_id = ?', params[:student_id], params[:practical_id]).empty?
        Attendance.create!(student_id: params[:student_id], practical_id: params[:practical_id])
        flash[:notice] = "Attendance is recorded successfully for student with ID: #{params[:sam_student_id]}"
        redirect_to record_path
      else 
        flash[:alert] = "Attendance is already recorded for student with ID: #{params[:sam_student_id]}"
        redirect_to record_path
      end
    else
      flash[:alert] = "Attendance with invalid details has not been recorded"
      redirect_to record_path
    end
  end
  
end
