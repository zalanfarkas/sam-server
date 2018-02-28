class ManualAttendanceRecordingController < ApplicationController
  before_action :authenticate_sam_user
  
  
  def index
    practicals_of_demonstrator = Demonstrator.find_practicals("sam_id", authenticate_sam_user)
    if practicals_of_demonstrator.nil? || practicals_of_demonstrator.empty? 
      p "Demonstrator doesn't have practicals"
    end
    current_time = DateTime.now
    @practicals = practicals_of_demonstrator.where('start_time <= ? AND end_time >= ?', current_time, current_time)
    if @practicals.empty? #|| #practicals.first.course.nil? || practicals.count = 0
      p "Demonstrator doesn't have practical at this time"
    else
      return @practicals
    end
  end
  
  def search
    
  end
  
  private
  def authenticate_sam_user
    if staff_signed_in?
      #current_user = current_staff
      puts "staff"
      return current_staff.sam_staff_id
      
    elsif student_signed_in? && Demonstrator.exists?(:sam_demonstrator_id => current_student.sam_student_id)
      #current_user = current_student
      puts current_student.id
      puts "student"
      return current_student.sam_student_id

    else
      puts "not logged in"
      redirect_to root_path
    end
  end
      
  
  
end
