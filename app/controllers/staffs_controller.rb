class StaffsController < ApplicationController
  before_action :authenticate_staff!
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
  
  def dashboard
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
        redirect_to dashboard_path
      end
    end
      
    p @courses.inspect
    p @hash.inspect
  end
  
  def remove_c6
    certificate_id = params[:certificate_id]
    student_name = params[:student_name]
    AbsenceCertificate.destroy(certificate_id)
    flash[:notice] = "C6 remove for #{student_name}"
    redirect_to dashboard_path
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
      params.require(:staff).permit(:sam_staff_id, :first_name, :last_name, :card_id)
    end
end
