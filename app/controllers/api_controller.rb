class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def get_course_id
    type = params[:type]
    data = params[:data]
    
    if data.nil? 
      return render :json => {
        :success => false,
        :error => "Data must be provided"
      }
    end
    
    if type == "nfc"
        # Find demonstrator
        practicals_of_demonstrator = Demonstrator.find_practicals(type, data)
        puts "testas"
        puts practicals_of_demonstrator
        
        
        if practicals_of_demonstrator.nil? || practicals_of_demonstrator.empty? 
          return render :json => {
            :success => false,
            :error => "Demonstrator doesn't have practicals"
          }
        end
        
        # and filter them to leave only 1 which is currently happening, and then return it
        current_time = DateTime.now
        practicals = practicals_of_demonstrator.where('start_time <= ? AND end_time >= ?', current_time, current_time)
        
        if practicals.empty? #|| #practicals.first.course.nil? || practicals.count = 0
          return render :json => {
            :success => false,
            :error => "Demonstrator doesn't have practical at this time"
          }
        end
        
        render :json => {
          :success => true,
          :course_id => practicals.first.course.sam_course_id
        }
    end
    
  end
  
  def record_attendance
    type = params[:type]
    data = params[:data]
    course_id = params[:course_id]
    
    if data.nil? || type.nil? || course_id.nil?
      return render :json => {
        :success => false,
        :error => "Data, type or course id is empty"
      }
    end
    
    course = Course.find_by(sam_course_id: course_id)
    if course.nil?
      return render :json => {
        :success => false,
        :error => "Course is not found"
      }
    end
    
    if type == "nfc"
      student = Student.find_by(card_id: data)
      if student.nil?
        return render_json_error("Student not found")
      end
      
      # Check is student is enrolled for the course
      if Enrolment.where(["student_id = ? and course_id = ?", student.id, course.id]).nil?
        return render_json_error("Student is not enrolled for course: #{course_id}")
      end
      
      current_time = DateTime.now
      practicals = Practical.where('start_time <= ? AND end_time >= ? AND course_id = ?', current_time, current_time, course.id)
      if practicals.empty? #|| #practicals.first.course.nil? || practicals.count = 0
          return render :json => {
            :success => false,
            :error => "There are no practical at this time"
          }
      end
      Attendance.create(student_id: student.id, practical_id: practicals.first.id)
      
      render :json => { :success => true, :student_id => student.sam_student_id }
    end
    
  end
  
  def render_json_error(message)
    render :json => {
      :success => false,
      :error => message
    }
  end
end