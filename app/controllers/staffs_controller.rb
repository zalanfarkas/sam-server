class StaffsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_if_not_found
  before_action :authenticate_staff!
  before_action :is_course_coordinator?, only: [:manage_c6s, :remove_c6, :add_demonstrator, :create_demonstrator, :demonstrator_list, :delete_demonstrator, :destroy_demonstrator, :practical_details, :attendance_statistics, :attendance_statistics_for_certain_student]
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  #due to the is_course_coordinator? before action all users who reach this action have courses so no need to check whether it is nil
  def manage_c6s
    sam_student_id = params[:sam_student_id]
    @courses = current_staff.courses
    @hash = {}
    if sam_student_id.nil?
      @courses.each do |course|
        @hash[course.course_title] = AbsenceCertificate.where("certificate_type = ? AND course_id = ?", "C6", course.id)
      end
    else
      student = Student.find_by(sam_student_id: sam_student_id)
      if !student.nil?
        @courses.each do |course|
          @hash[course.course_title] = AbsenceCertificate.where("certificate_type = ? AND course_id = ? AND student_id = ?", "C6", course.id, student.id)
        end
      else
        flash[:alert] = "There is no student with student ID: #{sam_student_id}"
        redirect_to manage_c6s_path
      end
    end
      
    p @courses.inspect
    p @hash.inspect
  end
  
  def remove_c6
    certificate_id = params[:certificate_id]
    student_name = params[:student_name]
    AbsenceCertificate.destroy(certificate_id)
    flash[:notice] = "C6 removed for #{student_name}"
    redirect_to manage_c6s_path
  end
  
  #due to the is_course_coordinator? before action all users who reach this action have courses so no need to check whether it is nil
  def add_demonstrator
    @courses = current_staff.courses
    # find future practicals
    current_time = DateTime.now
    @practicals_of_course = {}
    @courses.each do |course|
      @practicals_of_course[course.course_title] = course.practicals.where('start_time >= ?', current_time)
    end
    p "practicals_of_course: #{@practicals_of_course}"
  end
  
  
  def create_demonstrator # testing still needed
    if params[:practical_ids].nil?
      flash[:alert] = "No selected practical submitted"
      redirect_to add_demonstrator_path
    else
      params[:practical_ids][:practical_ids].delete("")
      if params[:practical_ids][:practical_ids].empty?
        flash[:alert] = "No selected practical submitted"
        redirect_to add_demonstrator_path
      else
        failed = false
        # sam_id because it can be either sam_student_id or sam_staff_id
        sam_id = params[:sam_id]
        if Student.exists?(sam_student_id: sam_id) || Staff.exists?(sam_staff_id: sam_id)
          create_demonstrator_params[:practical_ids].each do |practical_id|
            if !Demonstrator.exists?(sam_demonstrator_id: sam_id, practical_id: practical_id)
              demonstrator = Demonstrator.new
              demonstrator.sam_demonstrator_id = sam_id
              demonstrator.practical_id = practical_id.to_i
              if !demonstrator.save
                flash[:alert] = "Failed to save"
                failed = true
                break
               
              end
            else
              flash[:warning] = "Student/Staff is already a demonstrator on one of the selected practicals"
            end
            flash[:notice] = "Demonstrator added to practical(s)!" if !failed
          end
          redirect_to add_demonstrator_path #demonstrator_list_path
        else
          flash[:alert] = "Student/Staff (with ID: #{sam_id}) is not found"
          redirect_to add_demonstrator_path
        end
      end
    end
  end
  
  #due to the is_course_coordinator? before action all users who reach this action have courses so no need to check whether it is nil
  def demonstrator_list
    @hash = {}
    @courses = current_staff.courses
    @courses.each do |course|
      @hash[course.course_title] = {}
      #p "practical count: #{course.practicals.count}"
      course.practicals.each do |practical|
        @hash[course.course_title][practical.start_time] = {}
        #p "Demonstrators on a given practical: #{Demonstrator.where("practical_id = ?", practical.id).inspect}"
        demonstrators_on_given_practical = Demonstrator.where("practical_id = ?", practical.id)
        counter = demonstrators_on_given_practical.count
        counter.times do |i|
          @hash[course.course_title][practical.start_time][i] = {}
        end
        counter = 0
        demonstrators_on_given_practical.each do |demonstrate_on|
          #p "demonstrate_on: #{demonstrate_on.inspect}"
          demonstrator = Student.find_by(sam_student_id: demonstrate_on.sam_demonstrator_id)
          if demonstrator.nil?
            demonstrator = Staff.find_by(sam_staff_id: demonstrate_on.sam_demonstrator_id)
          end
          @hash[course.course_title][practical.start_time][counter][:sam_demonstrator_id] = demonstrate_on.sam_demonstrator_id
          @hash[course.course_title][practical.start_time][counter][:first_name] = demonstrator.first_name
          @hash[course.course_title][practical.start_time][counter][:last_name] = demonstrator.last_name
          @hash[course.course_title][practical.start_time][counter][:email] = demonstrator.email
          counter = counter + 1
        end
      end
    end
    #p @hash.inspect
  end
  
  def delete_demonstrator
    # sam_id means either sam_staff_id or sam_student_id
    if params[:sam_id] != nil
      if Demonstrator.exists?(sam_demonstrator_id: params[:sam_id])
        @hash = {}
        current_staff.courses.each do |course|
          @hash[course.course_title] = {}
          course.practicals.where("start_time > ?", DateTime.now).each do |practical|
            demonstrator_on_practical = Demonstrator.where("practical_id = ? AND sam_demonstrator_id = ?", practical.id, params[:sam_id])
            if !demonstrator_on_practical.empty?
              @hash[course.course_title][practical.start_time] =  demonstrator_on_practical
            end
          end
        end
      else
        flash[:alert] = "Demonstrator with ID: \"#{params[:sam_id]}\" not found"
        redirect_to delete_demonstrator_path
      end
    end  
  end

  def destroy_demonstrator
    Demonstrator.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to delete_demonstrator_path, notice: 'Demonstrator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def practical_details
    if params[:practical_id] != nil
      @practical = Practical.find(params[:practical_id])
      @attendances = @practical.attendances
    else
      flash[:alert] = "Practical not found!"
      redirect_to dashboard_path
    end
  end
  
  def attendance_statistics
      @courses = current_staff.courses
      @num_of_students_enrolled = {}
      @practicals_on_specific_weeks = {}
      @attendance_statistics = {}
      @courses.each do |course|
        @num_of_students_enrolled[course.course_title] = course.enrolments.count
        week_number = course.practicals.first.start_time.strftime("%U").to_i
        @practicals_on_specific_weeks[course.course_title] = [[]]
        index = 0
        course.practicals.where("end_time < ?", DateTime.now).each do |practical|
          if  practical.start_time.strftime("%U").to_i != week_number
            week_number = practical.start_time.strftime("%U").to_i
            index += 1
            @practicals_on_specific_weeks[course.course_title][index] = []
          end
          @practicals_on_specific_weeks[course.course_title][index] << practical
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
      #p @practicals_on_specific_weeks.inspect
  end
  
  def attendance_statistics_for_certain_student
    @courses = current_staff.courses
    if !params[:sam_student_id].nil? && !params[:course_id].nil?
      if Student.exists?(sam_student_id: params[:sam_student_id])
        @student = Student.find_by(sam_student_id: params[:sam_student_id])
        @course = @courses.find(params[:course_id])
        if Enrolment.exists?(student_id: @student.id, course_id: @course.id)
          week_number = @course.practicals.first.start_time.strftime("%U").to_i
          @practicals_on_specific_weeks = [[]]
          index = 0
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
          @practicals_on_specific_weeks.each do |practicals|
            practicals.each do |practical|
              if Attendance.exists?(practical_id: practical.id, student_id: @student.id)
                @attendance_on_practicals[index] = true
              end
            end
            index += 1
          end
        else
          flash[:alert] = "Student with ID: \'#{params[:sam_student_id]}\' is not enrolled for that course!"
          redirect_to attendance_statistics_for_certain_student_path 
        end
      else
        flash[:alert] = "Student with ID: \'#{params[:sam_student_id]}\' not found!"
        redirect_to attendance_statistics_for_certain_student_path
      end
    end
  end

  
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
    def create_demonstrator_params
      params.require(:practical_ids).permit(:sam_student_id, practical_ids: [])
    end
    
end
