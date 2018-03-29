# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# controller is automatically generated
# kept only for testing purposes
# real life users cannot access it
class PracticalsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_if_not_found
  before_action :authenticate_staff!
  before_action :set_practical, only: [:show, :edit, :update, :destroy]

  # GET /practicals
  # GET /practicals.json
  def index
    @practicals = Practical.all
  end

  # GET /practicals/1
  # GET /practicals/1.json
  def show
  end

  # GET /practicals/new
  def new
    @practical = Practical.new
  end

  # GET /practicals/1/edit
  def edit
  end

  # POST /practicals
  # POST /practicals.json
  def create
    @practical = Practical.new(practical_params)

    respond_to do |format|
      if @practical.save
        format.html { redirect_to @practical, notice: 'Practical was successfully created.' }
        format.json { render :show, status: :created, location: @practical }
      else
        format.html { render :new }
        format.json { render json: @practical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practicals/1
  # PATCH/PUT /practicals/1.json
  def update
    respond_to do |format|
      if @practical.update(practical_params)
        format.html { redirect_to @practical, notice: 'Practical was successfully updated.' }
        format.json { render :show, status: :ok, location: @practical }
      else
        format.html { render :edit }
        format.json { render json: @practical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practicals/1
  # DELETE /practicals/1.json
  def destroy
    @practical.destroy
    respond_to do |format|
      format.html { redirect_to practicals_url, notice: 'Practical was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practical
      @practical = Practical.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practical_params
      params.require(:practical).permit(:start_time, :end_time, :course_id)
    end
end
