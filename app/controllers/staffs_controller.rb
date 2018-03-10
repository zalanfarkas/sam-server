class StaffsController < ApplicationController
  before_action :authenticate_staff! #probably not needed
  before_action :is_course_coordinator?, only: [:manage_c6s, :remove_c6, :add_demonstrator, :create_demonstrator, :demonstrator_list]
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

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
        redirect_to record_path
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
    redirect_to dashboard_path
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
        sam_student_id = params[:sam_student_id]
        if Student.exists?(sam_student_id: sam_student_id)
          create_demonstrator_params[:practical_ids].each do |practical_id|
            if !Demonstrator.exists?(sam_demonstrator_id: sam_student_id, practical_id: practical_id)
              demonstrator = Demonstrator.new
              demonstrator.sam_demonstrator_id = sam_student_id
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
          flash[:alert] = "Student (with ID: #{sam_student_id}) is not found"
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
  
  def update_demonstrator
    
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
