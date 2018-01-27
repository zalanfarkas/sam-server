class ApiController < ApplicationController
  
  def get_course_id
    type = params[:type]
    data = params[:data]
    
    if data.nil? 
      return 
    end
    
    if type == "nfc"
      #course = Demonstrator.get_course(data)
      course = Demonstrator.dasdsakdjsakd(data).course
      
      # Time checking to get course which has practical at the momment
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