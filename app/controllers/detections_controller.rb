class DetectionsController < ApplicationController
  before_action :set_detection, only: %i[show edit update destroy]

  # GET /detections or /detections.json
  def index
    plague = params[:plague]
    if plague.present?
      @detections = Detection.where(plague:).order(created_at: :desc)
      detections = Detection.where(plague:).group(:severity).count
      severities = Detection.severities.keys
      @detections_by_number = severities.each_with_object({}) do |severity, hash|
        hash[severity] = detections[severity] || 0
      end
      @selected_plague = plague

      detections_by_week = Detection
                           .where(plague: params[:plague]) # Selección del plague si se pasa como parámetro
                           .select('EXTRACT(WEEK FROM created_at) AS week, EXTRACT(YEAR FROM created_at) AS year, severity, COUNT(*) AS detections_count')
                           .group('year, week, severity')
                           .order('year ASC, week ASC')

      # Dividir los datos según la severidad
      @detections_by_severity = {
        'low' => detections_by_week.select do |d|
                   d.severity == 'low'
                 end.map { |d| ["Semana #{d.week.to_i}, #{d.year.to_i}", d.detections_count] }.to_h,
        'medium' => detections_by_week.select do |d|
                      d.severity == 'medium'
                    end.map { |d| ["Semana #{d.week.to_i}, #{d.year.to_i}", d.detections_count] }.to_h,
        'high' => detections_by_week.select do |d|
                    d.severity == 'high'
                  end.map { |d| ["Semana #{d.week.to_i}, #{d.year.to_i}", d.detections_count] }.to_h
      }

    else
      @detections_by_severity = {}
      @selected_plague = nil
      @detections_by_number = {}
      @detections = Detection.all.order(created_at: :desc)
    end
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
    @detection.plague = :black_spot # O el valor que desees
    @detection.severity = :high # O el valor que desees

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
