class DetectionsController < ApplicationController
  before_action :set_detection, only: %i[show edit update destroy]

  # GET /detections or /detections.json
  def index
    @detections = Detection.all
  end

  # GET /detections/1 or /detections/1.json
  def show; end

  # GET /detections/new
  def new
    @detection = Detection.new
  end

  # GET /detections/1/edit
  def edit; end

  # POST /detections or /detections.json
  def create
    @detection = Detection.new(detection_params)

    respond_to do |format|
      if @detection.save
        format.html { redirect_to detection_url(@detection), notice: 'Detection was successfully created.' }
        format.json { render :show, status: :created, location: @detection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @detection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detections/1 or /detections/1.json
  def update
    respond_to do |format|
      if @detection.update(detection_params)
        format.html { redirect_to detection_url(@detection), notice: 'Detection was successfully updated.' }
        format.json { render :show, status: :ok, location: @detection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @detection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detections/1 or /detections/1.json
  def destroy
    @detection.destroy!

    respond_to do |format|
      format.html { redirect_to detections_url, notice: 'Detection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_detection
    @detection = Detection.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def detection_params
    params.require(:detection).permit(:plague, :severity, :image)
  end
end
