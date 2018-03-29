# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# this controller is reposible for handling the administrative features available only to course coordinators
class StaffsController < ApplicationController
  # redirects if the user tries to access non-existing
  # database record by specifying url parameter manually
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_if_not_found
  # only authenticated staff member
  # can access all the methods defined below
  before_action :authenticate_staff!
  # only authenticated course coordinator
  # can access all the methods listed in the array parameter
  before_action :is_course_coordinator?, only: [:manage_c6s, :remove_c6, :add_demonstrator, :create_demonstrator, :demonstrator_list, :delete_demonstrator, :destroy_demonstrator, :practical_details, :attendance_statistics, :attendance_statistics_for_certain_student]
  # sets @staff instance variable for the methods listed in the array parameter
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  # due to the is_course_coordinator? before action all users who reach this action have courses so no need to check whether it is nil
  # displays the list of students who missed practicals for the courses belonging to the course coordinator
  def manage_c6s
    sam_student_id = params[:sam_student_id]
    # retrieves courses which are supervised by the course coordinator
    @courses = current_staff.courses
    @hash = {}
    # if no student ID is submitted,
    # it lists all the students who missed practicals for the courses belonging to the course coordinator
    if sam_student_id.nil?
      @courses.each do |course|
        @hash[course.course_title] = AbsenceCertificate.where("certificate_type = ? AND course_id = ?", "C6", course.id)
      end
    else
      # if a student ID is submitted, the absence certificates for that student are displayed
      student = Student.find_by(sam_student_id: sam_student_id)
      # if the student exists in the database, a hash is filled with their absence certificates (to be rendered/presented later in the corresponding view)
      if !student.nil?
        @courses.each do |course|
          @hash[course.course_title] = AbsenceCertificate.where("certificate_type = ? AND course_id = ? AND student_id = ?", "C6", course.id, student.id)
        end
      # if no student is found with that ID, it sets an alert message and redirects user to the manage_c6s page
      else
        flash[:alert] = "There is no student with student ID: #{sam_student_id}"
        redirect_to manage_c6s_path
      end
    end
  end
  
  
  # it called when the course coordinator click "Remove" (Remove C6)
  # it deletes the appropriate absence certificate entry from the database
  def remove_c6
    certificate_id = params[:certificate_id]
    student_name = params[:student_name]
    AbsenceCertificate.destroy(certificate_id)
    # it sets a feedback message and redirects user to the manage_c6s page
    flash[:notice] = "C6 removed for #{student_name}"
    redirect_to manage_c6s_path
  end
  
  # due to the is_course_coordinator? before action all users who reach this action have courses so no need to check whether it is nil
  # lists future practicals for the courses of the course coordinator
  def add_demonstrator
    @courses = current_staff.courses
    # find future practicals
    current_time = DateTime.now
    @practicals_of_course = {}
    @courses.each do |course|
      @practicals_of_course[course.course_title] = course.practicals.where('start_time >= ?', current_time)
    end
  end
  
  # adds demonstrator to the submitted list of practicals
  def create_demonstrator
    # if empty form is submitted, it sets error message and redirects to add_demonstrator page
    if params[:practical_ids].nil?
      flash[:alert] = "No selected practical submitted"
      redirect_to add_demonstrator_path
    # if there is a student ID submitted, it proceeds with the rest of the validations 
    else
      # the first element of the list is an empty string due to the implementation of the select field
      params[:practical_ids][:practical_ids].delete("")
      # if no practical is selected and submitted, it sets error message and redirects to add_demonstrator page
      if params[:practical_ids][:practical_ids].empty?
        flash[:alert] = "No selected practical submitted"
        redirect_to add_demonstrator_path
      # if there are submitted practicals, it proceeds with the rest of the validations 
      else
        # since it tries to add more than one new entries, 
        # we need a boolean to set an alert notification when any of insertions were not successful
        failed = false
        # sam_id because it can be either sam_student_id or sam_staff_id
        sam_id = params[:sam_id]
        # checks whether the demonstrator is either an existing staff or an existing student
        if Student.exists?(sam_student_id: sam_id) || Staff.exists?(sam_staff_id: sam_id)
          create_demonstrator_params[:practical_ids].each do |practical_id|
            # only adds the demonstrator to a practical if they are not already there
            if !Demonstrator.exists?(sam_demonstrator_id: sam_id, practical_id: practical_id)
              demonstrator = Demonstrator.new
              demonstrator.sam_demonstrator_id = sam_id
              demonstrator.practical_id = practical_id.to_i
              if !demonstrator.save
                # indicates for the users if any of the insertion were not successful
                flash[:alert] = "Failed to save"
                failed = true
                # breaks the loop so the user can identify 
                # where the demonstrator creation is failed
                break
               
              end
              
            # if the demonstrator is already added to a certain practical, the user is notified by a warning message
            else
              flash[:warning] = "Student/Staff is already a demonstrator on one of the selected practicals"
            end
            
            # if the whole demonstrator creation procedure was successful, 
            # it sets a feedback message to notify the user about the success
            flash[:notice] = "Demonstrator added to practical(s)!" if !failed
          end
          redirect_to add_demonstrator_path #demonstrator_list_path
          
        # if the entered ID is not a valid student or staff ID, it sets an alert message and redirects the user to the add_demontrator page
        else
          flash[:alert] = "Student/Staff (with ID: #{sam_id}) is not found"
          redirect_to add_demonstrator_path
        end
      end
    end
  end
  
  # due to the is_course_coordinator? before action all users who reach this action have courses so no need to check whether it is nil
  # lists all the demonstrator for each practical of the courses of the course coordinator
  # it stores the necessary information in a nested hash which is rendered/presented in the corresponding view
  def demonstrator_list
    @hash = {}
    # retrieves courses which are supervised by the course coordinator
    @courses = current_staff.courses
    @courses.each do |course|
      # starts building a hash containing the neccessary information
      @hash[course.course_title] = {}
      # retrieves all the practicals for the course
      course.practicals.each do |practical|
        @hash[course.course_title][practical.start_time] = {}
        # retrieves the demonstrators for the practicals
        demonstrators_on_given_practical = Demonstrator.where("practical_id = ?", practical.id)
        # counts how many demonstrators will be on the practical
        counter = demonstrators_on_given_practical.count
        # initialising a hash for each demonstrator
        counter.times do |i|
          @hash[course.course_title][practical.start_time][i] = {}
        end
        counter = 0
        # goes through each demonstrator for a practical and restrieves their necessary information
        demonstrators_on_given_practical.each do |demonstrate_on|
          # checks whether the demonstrator is a staff member or a student
          demonstrator = Student.find_by(sam_student_id: demonstrate_on.sam_demonstrator_id)
          if demonstrator.nil?
            demonstrator = Staff.find_by(sam_staff_id: demonstrate_on.sam_demonstrator_id)
          end
          # stores the details of the demonstrator which will be presented in the corresponding view
          @hash[course.course_title][practical.start_time][counter][:sam_demonstrator_id] = demonstrate_on.sam_demonstrator_id
          @hash[course.course_title][practical.start_time][counter][:first_name] = demonstrator.first_name
          @hash[course.course_title][practical.start_time][counter][:last_name] = demonstrator.last_name
          @hash[course.course_title][practical.start_time][counter][:email] = demonstrator.email
          counter = counter + 1
        end
      end
    end
  end
  
  # after searching a demonstrator by ID number, 
  # it lists their practicals so the course coordinator can remove them from certain practicals
  def delete_demonstrator
    # checks whether a ID of demonstrator  is submitted
    # sam_id means either sam_staff_id or sam_student_id
    if params[:sam_id] != nil
      # checks whether a valid ID number is submitted, if so, it proceeds with the information gathering
      if Demonstrator.exists?(sam_demonstrator_id: params[:sam_id])
        @hash = {}
        # retrieves courses which are supervised by the course coordinator
        current_staff.courses.each do |course|
          # initialises hash used to present information in the corresponding view
          @hash[course.course_title] = {}
          # gathers only the future practicals for the courses of the course coordinator
          # since demontrators can be deleted from only future practicals
          course.practicals.where("start_time > ?", DateTime.now).each do |practical|
            demonstrator_on_practical = Demonstrator.where("practical_id = ? AND sam_demonstrator_id = ?", practical.id, params[:sam_id])
            if !demonstrator_on_practical.empty?
              # stores the necessary information in the hash used to present information in the corresponding view
              @hash[course.course_title][practical.start_time] =  demonstrator_on_practical
            end
          end
        end
      
      # if the submitted ID number is not found. it sets an alert message and redirects the user to the delete_demonstrator page
      else
        flash[:alert] = "Demonstrator with ID: \"#{params[:sam_id]}\" not found"
        redirect_to delete_demonstrator_path
      end
    end  
  end

  # deletes the selected demonstrator from a given practical
  def destroy_demonstrator
    Demonstrator.find(params[:id]).destroy
    # after successful deletion, it sets a feedback message and redirects the user to the delete_demonstrator page
    respond_to do |format|
      format.html { redirect_to delete_demonstrator_path, notice: 'Demonstrator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # collects students attended a certain practical 
  # => basically, it prepares an attendance sheet to be displayed
  # it also makes possible for the user to see the number of students attended that practical
  def practical_details
    if params[:practical_id] != nil
      @practical = Practical.find(params[:practical_id])
      @attendances = @practical.attendances
    # in case of invalid practical id, it sets an alert 
    # message and redirects the user to the dashboard
    else
      flash[:alert] = "Practical not found!"
      redirect_to dashboard_path
    end
  end
  
  # groups past practicals for the courses of the course coordinator by weeks and calculates how many students attended 
  def attendance_statistics
      # retrieves courses which are supervised by the course coordinator
      @courses = current_staff.courses
      # used to display how many student attended out of enrolled students
      @num_of_students_enrolled = {}
      # initiliasing hashes to gather neccessary information
      @practicals_on_specific_weeks = {}
      @attendance_statistics = {}
      
      # groupping the past practicals for each course by weeks
      @courses.each do |course|
        # retrieves the number of students enrolled to the course
        @num_of_students_enrolled[course.course_title] = course.enrolments.count
        # retrives the week number from the start_time of the first practical
        week_number = course.practicals.first.start_time.strftime("%U").to_i
        @practicals_on_specific_weeks[course.course_title] = [[]]
        index = 0
        course.practicals.where("end_time < ?", DateTime.now).each do |practical|
          # moving to the next array element when the week number of the current practical
          # is not equal to the week number of the previous one
          if  practical.start_time.strftime("%U").to_i != week_number
            week_number = practical.start_time.strftime("%U").to_i
            index += 1
            @practicals_on_specific_weeks[course.course_title][index] = []
          end
          @practicals_on_specific_weeks[course.course_title][index] << practical
        end
      end
      
      # calculates how many student attended the practicals during the week
      @courses.each do |course|
        @attendance_statistics[course.course_title] = Array.new(@practicals_on_specific_weeks[course.course_title].count, 0)
        @practicals_on_specific_weeks[course.course_title].each_with_index do |practicals_on_same_week, index|
          practicals_on_same_week.each do |practical|
            @attendance_statistics[course.course_title][index] += practical.attendances.count
          end
        end
      end
  end
  
  # collects the information neccessary to show whether the student attended at least one practical each week for a given course
  def attendance_statistics_for_certain_student
    # retrieves courses which are supervised by the course coordinator
    @courses = current_staff.courses
    # checks whether the required data is submitted so the procudere can proceed
    if !params[:sam_student_id].nil? && !params[:course_id].nil?
      
      # checks whether submitted the student ID belongs to a student in the database
      # if so, it retrieves the student's and course's data
      if Student.exists?(sam_student_id: params[:sam_student_id])
        @student = Student.find_by(sam_student_id: params[:sam_student_id])
        @course = @courses.find(params[:course_id])
        
        # checks whether the student is enrolled to that course
        if Enrolment.exists?(student_id: @student.id, course_id: @course.id)
          # retrives the week number from the start_time of the first practical
          week_number = @course.practicals.first.start_time.strftime("%U").to_i
          @practicals_on_specific_weeks = [[]]
          index = 0
          
          # retrieves only the past practicals for the course and groups them by week
          @course.practicals.where("end_time < ?", DateTime.now).each do |practical|
            if  practical.start_time.strftime("%U").to_i != week_number
              week_number = practical.start_time.strftime("%U").to_i
              index += 1
              @practicals_on_specific_weeks[index] = []
            end
          @practicals_on_specific_weeks[index] << practical
          end
          
          @attendance_on_practicals = Array.new(@practicals_on_specific_weeks.count,false)
          index = 0
          
          # goes through the practicals for each week and checks whether 
          # the student attended at least one practical on a given week
          @practicals_on_specific_weeks.each do |practicals|
            practicals.each do |practical|
              if Attendance.exists?(practical_id: practical.id, student_id: @student.id)
                @attendance_on_practicals[index] = true
              end
            end
            index += 1
          end
        # if the submitted student ID is valid, but the student is not enrolled to that course,
        # it sets an alert message and redirects the user to the attendance_history page
        else
          flash[:alert] = "Student with ID: \'#{params[:sam_student_id]}\' is not enrolled for that course!"
          redirect_to attendance_history_path 
        end
        
      # if an invalid student ID was submitted, it sets an alert message
      # and redirects the user to the attendance_history page
      else
        flash[:alert] = "Student with ID: \'#{params[:sam_student_id]}\' not found!"
        redirect_to attendance_history_path
      end
    end
  end

  
  # AUTO-GENERATED code 
  # used only for testing purposes
  # not avabilable in production
  # no features depend on the auto-generated code below
  
  ###### start of auto-generated code ######
  
  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.all
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
  end
  
  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    respond_to do |format|
      if @staff.update(staff_params)
        format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params.require(:staff).permit(:sam_staff_id, :first_name, :last_name, :card_id, practical_ids)
    end
    
    
  ###### end of auto-generated code ######
  
    def create_demonstrator_params
      params.require(:practical_ids).permit(:sam_student_id, practical_ids: [])
    end
    
end
