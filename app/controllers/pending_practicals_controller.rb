class PendingPracticalsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :is_staff_for_practical?
  before_action :set_pending_practical, only: [:show, :edit, :update, :destroy]

  # GET /pending_practicals
  # GET /pending_practicals.json
  def index
    @pending_practicals = PendingPractical.all
  end

  # GET /pending_practicals/1
  # GET /pending_practicals/1.json
  def show
  end

  # GET /pending_practicals/new
  # due to the is_staff_for_practical? before_action we know that the users who reach this action have practical(s)
  # but we still need to check whether they have any practicals at the moment
  # current_practicals_for_course_coordinator and current_practicals_for_demonstrator(id) methods are inherited from application controller
  def new
    @pending_practical = PendingPractical.new
    if session[:user_type] == "staff_course_coordinator" #since staff is course coordinator, it is already checked that current_staff.courses is not empty
      @current_practicals = current_practicals_for_course_coordinator
    elsif session[:user_type] == "staff_course_coordinator_and_demonstrator"
      @current_practicals = current_practicals_for_course_coordinator.concat(current_practicals_for_demonstrator(current_staff.sam_staff_id))
    elsif session[:user_type] == "staff_demonstrator"
      @current_practicals = current_practicals_for_demonstrator(current_staff.sam_staff_id)
    elsif session[:user_type] == "student_demonstrator"
      @current_practicals = current_practicals_for_demonstrator(current_student.sam_student_id)
    else
      redirect_to dashboard_path
    end
    if @current_practicals.empty?
      flash[:warning] = "You don't have any practicals at the moment!"
      redirect_to dashboard_path
    end
  end

  # GET /pending_practicals/1/edit
  def edit
  end

  # POST /pending_practicals
  # POST /pending_practicals.json
  def create
    @pending_practical = PendingPractical.new(pending_practical_params)

    respond_to do |format|
      if @pending_practical.save
        format.html { redirect_to dashboard_path, notice: 'Pending practical was successfully created.' }
        format.json { render :show, status: :created, location: @pending_practical }
      else
        format.html { render :new }
        format.json { render json: @pending_practical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pending_practicals/1
  # PATCH/PUT /pending_practicals/1.json
  def update
    respond_to do |format|
      if @pending_practical.update(pending_practical_params)
        format.html { redirect_to @pending_practical, notice: 'Pending practical was successfully updated.' }
        format.json { render :show, status: :ok, location: @pending_practical }
      else
        format.html { render :edit }
        format.json { render json: @pending_practical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pending_practicals/1
  # DELETE /pending_practicals/1.json
  def destroy
    @pending_practical.destroy
    respond_to do |format|
      format.html { redirect_to pending_practicals_url, notice: 'Pending practical was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pending_practical
      @pending_practical = PendingPractical.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pending_practical_params
      params.require(:pending_practical).permit(:raspberry_pi_id, :practical_id)
    end
    

    
end
