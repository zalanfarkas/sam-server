class HomepagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_if_not_found
  def login
    if current_user
      redirect_to dashboard_path
    end
  end

  def dashboard
    if ["staff_course_coordinator","staff_course_coordinator_and_demonstrator"].include?(session[:user_type])
      @courses = current_staff.courses
      @courses.each do |course|
        @num_of_students_enrolled = course.enrolments.count
        #students_of_course = Enrolment.where(course_id: course.id)#.select(:student_id)
        praticals_on_same_week = []
        pratical_counter = 0
        week_counter = 0
        course.practicals.each do |practical|
        #first practical of the week can be Monday or not Monday
          if practical.start_time.wday == 1
            praticals_on_same_week[week]
          #students_on_practical = Attendance.where(practical_id: practical.id)
          practical.attendances
        end
      end
    end
  end
end
