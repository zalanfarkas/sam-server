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
      @num_of_students_enrolled = {}
      @practicals_on_specific_weeks = {}
      @attendance_statistics = {}
      @courses.each do |course|
        @num_of_students_enrolled[course.course_title] = course.enrolments.count
        #students_of_course = Enrolment.where(course_id: course.id)#.select(:student_id)
        week_number = course.practicals.first.start_time.strftime("%U").to_i
        @practicals_on_specific_weeks[course.course_title] = [[]]
        index = 0
        #@practicals_on_specific_weeks[course.course_title]["Practical #{index}"] = []
        course.practicals.each do |practical|
          if  practical.start_time.strftime("%U").to_i != week_number
            week_number = practical.start_time.strftime("%U").to_i
            index += 1
            @practicals_on_specific_weeks[course.course_title][index] = []
          end
          @practicals_on_specific_weeks[course.course_title][index] << practical
          #practical.attendances
        end
      end
      @courses.each do |course|
        
        @attendance_statistics[course.course_title] = Array.new(@practicals_on_specific_weeks[course.course_title].count, 0)
        @practicals_on_specific_weeks[course.course_title].each_with_index do |practicals_on_same_week, index|
          practicals_on_same_week.each do |practical|
            @attendance_statistics[course.course_title][index] += practical.attendances.count
          end
        end
      end
      p @practicals_on_specific_weeks.inspect
    end
  end
end
