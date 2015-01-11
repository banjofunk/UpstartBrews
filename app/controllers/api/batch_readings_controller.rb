class Api::BatchReadingsController < ApplicationController

  def index
    @batch_readings = BatchReading.where(:batch_id => params[:batch_id])
  end

  def show
    @batch_reading = BatchReading.find(params[:id])
  end

  def edit
    @batch_reading = BatchReading.find(params[:id])
  end

  def new
    @batch_reading = BatchReading.new()
  end

  def create
    params.permit!
    params[:batch_reading][:reading_date] = Time.now
    @batch_reading = BatchReading.new(params[:batch_reading])
    @batch_reading.save
    render :partial => "api/batch_readings/batch_reading.json", :locals => { :batch_reading => @batch_reading }
  end

  def update
    params.permit!
    @batch_reading = BatchReading.find(params[:id])
    @batch_reading.update_attributes(params[:batch_reading])
    render :partial => "api/batch_readings/batch_reading.json", :locals => { :batch_reading => @batch_reading }
  end

  def destroy
    @batch_reading = BatchReading.find(params[:id])
    @batch_reading.destroy
    render :partial => "api/batch_readings/batch_reading.json", :locals => { :batch_reading => @batch_reading }
  end
end
