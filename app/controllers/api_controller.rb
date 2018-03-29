# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# This controller is reposible for the communication
# between server and raspberry pi units

class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  # Get course id and other practical details
  def get_course_id
    # Get type of input device and data from that device
    type = params[:type]
    data = params[:data]
  
    # If data is missing return error
    if data.nil? 
      return render :json => {
        :success => false,
        :error => "NO DATA RECEIVED"
      }
    end
    
    # Find all the  practicals for given person
    practicals_of_demonstrator = Demonstrator.find_practicals(type, data)
    
    # If person doesn't have practicals sends response to PI
    if practicals_of_demonstrator.nil? || practicals_of_demonstrator.empty? 
      return render :json => {
        :success => false,
        # spaces are intentional to fit the text properly to the LCD screen
        :error => "YOU ARE NOT                             A DEMONSTRATOR"
      }
    end
    
    # Filter practicals to leave only 1 which is currently happening, and then return it
    current_time = DateTime.now
    practicals = practicals_of_demonstrator.where('start_time <= ? AND end_time >= ?', current_time, current_time)
    
    # Check if person has currently running practicals
    if practicals.empty?
      return render :json => {
        :success => false,
        # spaces are intentional to fit the text properly to the LCD screen
        :error => "NO CURRENT                              PRACTICALS"
      }
    end
    
    # Create array for fingerprint templates
    fingerprint_templates = Array.new
    # Find all the students who are enrolled for course and put their fingerprint template to array
    Enrolment.where(["course_id = ?", practicals.first.course.id]).each do |enrolment|
      fingerprint_templates << enrolment.student.fingerprint_template if enrolment.student.fingerprint_template.present?
    end

    # Return json with practical information
    render :json => {
      :success => true,
      :course_id => practicals.first.course.sam_course_id,
      :end_time => practicals.first.end_time,
      :templates => fingerprint_templates
    }
    
  end
  
  # Tries to record attendance
  def record_attendance
    type = params[:type]
    data = params[:data]
    course_id = params[:course_id]
    
    # If some field are empty, show error to the user
    if data.nil? || type.nil? || course_id.nil?
      return render :json => {
        :success => false,
        :error => "MISSING DATA"
      }
    end
    
    # Try to find course from given parameter
    student = Student.new
    course = Course.find_by(sam_course_id: course_id)
    if course.nil?
      return render :json => {
        :success => false,
        :error => "COURSE NOT FOUND"
      }
    end
    
    if type == "nfc"
      # Try to find student using nfc data
      student = Student.find_by(card_id: data)
      if student.nil?
        # spaces are intentional to fit the text properly to the LCD screen
        return render_json_error("STUDENT                                 NOT FOUND")
      end
    elsif type == "fingerprint"
      # Try to find student using fingerprint data
      student = Student.find_by(fingerprint_template: data)
      if student.nil?
        # spaces are intentional to fit the text properly to the LCD screen
        return render_json_error("STUDENT                                 NOT FOUND")
      end
    else 
      # Given type is not found
      return render_json_error("TYPE NOT FOUND")
    end
    
    
      # Check is student is enrolled for the course
      if Enrolment.where(["student_id = ? and course_id = ?", student.id, course.id]).empty?
        return render_json_error("NOT ENROLLED                            FOR #{course_id}")
      end
      
      if Rails.env == "production"
        current_time = DateTime.now
      else # if the enviroment is either test or development
         # so we can test it even if there is no real practical at testing time
        current_time = Practical.first.start_time
      end
      
      # Find currently running practicals for the course
      practicals = Practical.where('start_time <= ? AND end_time >= ? AND course_id = ?', current_time, current_time, course.id)
      if practicals.empty?
          return render :json => {
            :success => false,
            # spaces are intentional to fit the text properly to the LCD screen
            :error => "NO PRACTICALS                           AT THE MOMENT" #There are no practicals at this time
          }
      end
      
      # Check if student has already recorded attendance
      if Attendance.where('student_id = ? AND practical_id = ?', student.id, practicals.first.id).exists?
        return render :json => {
            :success => false,
            # spaces are intentional to fit the text properly to the LCD screen
            :error => "ALREADY                                 RECORDED"
          }
      end
      
      # Record attendance and send response
      Attendance.create(student_id: student.id, practical_id: practicals.first.id)
      render :json => { :success => true, :student_id => student.sam_student_id }
  end
  
  # Returns pending practicals
  def pending_practicals
    # Gets raspberry pi id
    raspberry_pi_id = params[:data]
    
    # If id is not provided return error
    if raspberry_pi_id.nil?
      return render :json => {
        :success => false,
        # spaces are intentional to fit the text properly to the LCD screen
        :error => "NO DEVICE ID                            SUBMITTED"
      }
    end
    
    # Try to get pending practical
    pending_practical = PendingPractical.find_by(raspberry_pi_id: raspberry_pi_id)
    # There is not practical pending for raspberry pi with given id
    if pending_practical.nil?
      return render :json => {
        :success => true,
        :pending => false
      }
    end
    
    # If practical doesn't have course return error
    if pending_practical.practical.course.nil?
      return render :json => {
        :success => false,
        # spaces are intentional to fit the text properly to the LCD screen
        :error => "PRACTICAL HAS                           NO COURSE" #
      }
    end
    
    # Return pending practicals
    render :json => {
        :success => true,
        :pending => true,
        :course_id => pending_practical.practical.course.sam_course_id,
        :end_time => pending_practical.practical.end_time
    }
    
    # Delete practical from pending practicals
    pending_practical.delete
  end
  
  # Uploads fingerprint to database
  def upload_fingerprint
    card_id = params[:card_id]
    fingerprint = params[:fingerprint]
    
    # If card id or fingerpint template not provided, return an error
    if card_id.nil? || fingerprint.nil?
      return render :json => {
        :success => false,
        # spaces are intentional to fit the text properly to the LCD screen
        :error => "MISSING ID                              OR FINGERPRINT" #ID and fingerprint data must be provided
      }
    end
    
    person = nil
    # Look for the person in students record
    person = Student.find_by(card_id: card_id)
    # If didn't find in student table look in staff table
    person = Staff.find_by(card_id: card_id) if person == nil
    
    # If person not found return error
    if person.nil?
      return render :json => {
        :success => false,
        # spaces are intentional to fit the text properly to the LCD screen
        :error => "PERSON'S ID                             NOT FOUND" # Person with given card id doesn't exists
      }
    end
    
    # Update person's fingerprint template
    person.update_attribute(:fingerprint_template, fingerprint)
    return render :json => {
      :success => true
    }
  end
  
  # Fetch templates for currently running practicals
  def current_templates
    # Find currently running practicals
    current_time = DateTime.now
    practicals = Practical.where('start_time <= ? AND end_time >= ?', current_time, current_time)
    
    fingerprint_templates = Array.new
    # Go through each practical
    practicals.each do |practical|
      # Add course coordinator template
      fingerprint_templates << practical.course.staff.fingerprint_template if practical.course.staff.fingerprint_template.present?
      # Find demonstrators for each practical
      practical.demonstrators.each do |demonstrator|
        # Add demonstrator templates 
        fingerprint_templates << demonstrator.find_person.fingerprint_template if demonstrator.find_person.fingerprint_template.present?
      end
    end
    
    # Return templates
    return render :json => {
      :success => true,
      :templates => fingerprint_templates
    }
  end
  
  def render_json_error(message)
    render :json => {
      :success => false,
      :error => message
    }
  end
end
