class Api::BatchReadingsController < ApplicationController
  load_and_authorize_resource

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
    params[:batch_reading][:reading_date] = Time.now
    @batch_reading = BatchReading.new(params[:batch_reading])
    @batch_reading.save
    render :partial => "api/batch_readings/batch_reading.json", :locals => { :batch_reading => @batch_reading }
  end

  def update
    @batch_reading = BatchReading.find(params[:id])
    params[:batch_reading][:reading_date] =  Time.strptime(params[:batch_reading][:reading_date], "%m/%d/%Y")
    @batch_reading.update_attributes(params[:batch_reading])
    render :partial => "api/batch_readings/batch_reading.json", :locals => { :batch_reading => @batch_reading }
  end

  def destroy
    @batch_reading = BatchReading.find(params[:id])
    @batch_reading.destroy
    render :partial => "api/batch_readings/batch_reading.json", :locals => { :batch_reading => @batch_reading }
  end

  private

  def batch_reading_params
    params.require(:batch_reading).permit(:id, :batch_id, :brix, :ph, :temp, :reading_date)
  end
end
