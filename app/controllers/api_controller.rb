class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def get_course_id
    type = params[:type]
    data = params[:data]
    
    if data.nil? 
      return 
    end
    
    if type == "nfc"
        render :json => {:course_id => 1}
      
      
        # Find demonstrator
        practicals_of_demonstrator = Demonstrator.find_practicals_for(data)
        
        if practicals_of_demonstrator.empty? 
          return
        end
        
        # and filter them to leave only 1 which is currently happening, and then return it
        current_time = DateTime.now
        practicals = practicals_of_demonstrator.where('start_time <= ? AND end_time >= ?', current_time, current_time)
        
        if practicals.count > 1 || practicals.first.course.nil? || practicals.count = 0
             render :json => {"ERROR" => "Practical not found"}
            return
        end
        
        render :json => {:course_id => practicals.first.course.sam_course_id}
    end
    
  end
  
  def create 
    
    type = params[:type]
    data = params[:data]
    course_id = params[:course_id]
    
    if course_id.nil? || data.nil?
      # Handle error
      return 
    end
    
    course = Course.find(course_id)
    if course.nil?
      return
    end
  
    
    if type == "nfc" && params[:data] 
      student = Student.find_by(card_id: data)
      if student.nil?
        # Handle error
        return
      end
      
      if Enrolment.where(["student_id = ? and course = ?", student, course]).nil?
        return
      end
      
      
      Attendance.create(student_id: student.student_id, practical_id: practical_id)
      # R
      render :json => {:success => 1, :student_name => student.first_name, :course_title => course.title }
    end
    
    
  end


  def validate
    render :json => {:success => 1, :student_name => "Test", :course_title => "Test course" }
  end
end