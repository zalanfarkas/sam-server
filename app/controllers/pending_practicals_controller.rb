class PendingPracticalsController < ApplicationController
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
  def new
    @pending_practical = PendingPractical.new
    current_time = DateTime.now
    #p current_user.id
    #p current_user.class == Staff
    if current_user.class == Staff
      @current_practicals = []
      @courses = current_staff.courses
      @courses.each do |course|
        @current_practicals.concat(course.practicals.where('start_time <= ? AND end_time >= ?', current_time, current_time))
      end
    else
      @current_practicals = Demonstrator.find_practicals("sam_id", current_student.sam_student_id).where('start_time <= ? AND end_time >= ?', current_time, current_time)
    end
    p @current_practicals.inspect
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
        format.html { redirect_to @pending_practical, notice: 'Pending practical was successfully created.' }
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
