# controller is automatically generated
# kept only for testing purposes
# real life users cannot access it
class DemonstratorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_if_not_found
  before_action :set_demonstrator, only: [:show, :edit, :update, :destroy]

  # GET /demonstrators
  # GET /demonstrators.json
  def index
    @demonstrators = Demonstrator.all
  end

  # GET /demonstrators/1
  # GET /demonstrators/1.json
  def show
  end

  # GET /demonstrators/new
  def new
    @demonstrator = Demonstrator.new
  end

  # GET /demonstrators/1/edit
  def edit
  end

  # POST /demonstrators
  # POST /demonstrators.json
  def create
    @demonstrator = Demonstrator.new(demonstrator_params)

    respond_to do |format|
      if @demonstrator.save
        format.html { redirect_to @demonstrator, notice: 'Demonstrator was successfully created.' }
        format.json { render :show, status: :created, location: @demonstrator }
      else
        format.html { render :new }
        format.json { render json: @demonstrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /demonstrators/1
  # PATCH/PUT /demonstrators/1.json
  def update
    respond_to do |format|
      if @demonstrator.update(demonstrator_params)
        format.html { redirect_to @demonstrator, notice: 'Demonstrator was successfully updated.' }
        format.json { render :show, status: :ok, location: @demonstrator }
      else
        format.html { render :edit }
        format.json { render json: @demonstrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demonstrators/1
  # DELETE /demonstrators/1.json
  def destroy
    @demonstrator.destroy
    respond_to do |format|
      format.html { redirect_to demonstrators_url, notice: 'Demonstrator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demonstrator
      @demonstrator = Demonstrator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def demonstrator_params
      params.require(:demonstrator).permit(:sam_demonstrator_id, :practical_id)
    end
end
