class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def get_course_id
    type = params[:type]
    data = params[:data]
    # params with Pi ID so we can check which Pi sent it, maybe we can check against it so nobody can send a post request from home
    
    if data.nil? 
      return render :json => {
        :success => false,
        :error => "Data must be provided"
      }
    end
    
    if type == "nfc"
        # Find demonstrator
        practicals_of_demonstrator = Demonstrator.find_practicals(type, data)
        
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
        
        fingerprint_templates = Array.new
        # Find all the students who are enrolled for course
        Enrolment.where(["course_id = ?", practicals.first.course.id]).each do |enrolment|
          fingerprint_templates << enrolment.student.fingerprint_template
        end

        # Todo add code to add demonstrator and staff templates as well
        
        render :json => {
          :success => true,
          :course_id => practicals.first.course.sam_course_id,
          :end_time => practicals.first.end_time,
          :templates => fingerprint_templates
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
    
    student = Student.new
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
    elsif type == "fingerprint"
      student = Student.find_by(fingerprint_template: data)
      if student.nil?
        return render_json_error("Student not found")
      end
    else 
      return render_json_error("Type not found")
    end
    
    
     # Check is student is enrolled for the course
      if Enrolment.where(["student_id = ? and course_id = ?", student.id, course.id]).nil?
        return render_json_error("Student is not enrolled for course: #{course_id}")
      end
      
      if Rails.env == "production"
        current_time = DateTime.now
      else # if the enviroment is either test or development
         # so we can test it even if there is no real practical at testing time
        current_time = Practical.first.start_time
      end
      practicals = Practical.where('start_time <= ? AND end_time >= ? AND course_id = ?', current_time, current_time, course.id)
      if practicals.empty? #|| #practicals.first.course.nil? || practicals.count = 0
          return render :json => {
            :success => false,
            :error => "There are no practicals at this time"
          }
      end
      
      if Attendance.where('student_id = ? AND practical_id = ?', student.id, practicals.first.id).exists?
        return render :json => {
            :success => false,
            :error => "Attendance was already recorded"
          }
      end
      
      Attendance.create(student_id: student.id, practical_id: practicals.first.id)
      render :json => { :success => true, :student_id => student.sam_student_id }
  end
  
  def pending_practicals
    raspberry_pi_id = params[:data]
    
    if raspberry_pi_id.nil?
      return render :json => {
        :success => false,
        :error => "Raspberry id must be provided"
      }
    end
    
    pending_practical = PendingPractical.find_by(raspberry_pi_id: raspberry_pi_id)
    # There is not practical pending for raspberry pi with given id
    if pending_practical.nil?
      return render :json => {
        :success => true,
        :pending => false
      }
    end
    
    if pending_practical.practical.course.nil?
      return render :json => {
        :success => false,
        :error => "Practical doesn't have course"
      }
    end
    
    
    render :json => {
        :success => true,
        :pending => true,
        :course_id => pending_practical.practical.course.sam_course_id,
        :end_time => pending_practical.practical.end_time
    }
    
    # Delete practical from pending practicals
    pending_practical.delete
  end
  
  def upload_fingerprint
    card_id = params[:card_id]
    fingerprint = params[:fingerprint]
    
    if card_id.nil? || fingerprint.nil?
      return render :json => {
        :success => false,
        :error => "ID and fingerprint data must be provided"
      }
    end
    
    person = nil
    # Look for the person in students record
    person = Student.find_by(card_id: card_id)
    # If didn't find in student table look in staff table
    person = Staff.find_by(card_id: card_id) if person == nil
    
    if person.nil?
      return render :json => {
        :success => false,
        :error => "Person with given card id doesn't exists"
      }
    end
    
    person.update_attribute(:fingerprint_template, fingerprint)
    return render :json => {
      :success => true
    }
  end
  
  def render_json_error(message)
    render :json => {
      :success => false,
      :error => message
    }
  end
end