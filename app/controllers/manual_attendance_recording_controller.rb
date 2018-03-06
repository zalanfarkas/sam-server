class ManualAttendanceRecordingController < ApplicationController
  before_action :authenticate_sam_user
  
  
  def index
    @error = nil
    practicals_of_demonstrator = Demonstrator.find_practicals("sam_id", authenticate_sam_user)
    if practicals_of_demonstrator.nil? || practicals_of_demonstrator.empty? 
      @error = "Demonstrator doesn't have practicals"
    else
      current_time = DateTime.now
      @practicals = practicals_of_demonstrator.where('start_time <= ? AND end_time >= ?', current_time, current_time).select(:course_id).distinct
      if @practicals.empty? #|| #practicals.first.course.nil? || practicals.count = 0
        @error = "Demonstrator doesn't have practical at this time"
      end
    end
    
  end
  
  def search
    @error = nil
    @sam_student_id = params[:student_id]
    @course_id = params[:course_id]
    if @sam_student_id != "" && @course_id != ""
      @student = Student.find_by(sam_student_id: @sam_student_id)
      if @student.nil?
        flash[:alert] = "Invalid student ID has been submitted"
        redirect_to manual_attendance_recording_index_path
      else
        if !Enrolment.where('student_id = ? AND course_id = ?', @sam_student_id, @course_id).empty?
          @course = Course.find(@course_id)
        else
          @error = "Student has not been enrolled to this course"
        end
      end
    else
      flash[:alert] = "Empty seach has been submitted!"
      redirect_to manual_attendance_recording_index_path
    end
  end
  
  def attendance_recording
    if params[:course_id] != "" && params[:student_id]
      current_time = Time.now
      practical = Course.find(params[:course_id]).practicals.where('start_time <= ? AND end_time >= ?', current_time, current_time).first
      #Attendance => student id should be sam student id
      if Attendance.where('student_id = ? AND practical_id = ?', params[:student_id], practical.id).empty?
        Attendance.create!(student_id: params[:student_id], practical_id: practical.id)
        flash[:notice] = "Attendance is recorded successfully for student with ID: #{params[:sam_student_id]}"
        redirect_to manual_attendance_recording_index_path
      else 
        flash[:alert] = "Attendance is already recorded for student with ID: #{params[:sam_student_id]}"
        redirect_to manual_attendance_recording_index_path
      end
    else
      flash[:alert] = "Attendance with invalid details has not been recorded"
    end
  end
  
  private
  def authenticate_sam_user
    if staff_signed_in?
      return current_staff.sam_staff_id
      
    elsif student_signed_in? && Demonstrator.exists?(:sam_demonstrator_id => current_student.sam_student_id)
      return current_student.sam_student_id
    else
      redirect_to root_path
    end
  end
      
  
  
end
