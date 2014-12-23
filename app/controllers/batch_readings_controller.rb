class BatchReadingController < ApplicationController
  def index
    @batch_readings = BatchReading.where(:batch_id => params[:batch_id])
  end

  def show
    @batch_reading = BatchReading.find(params[:id])
  end

  def edit
    @batch_reading = BatchReading.find(params[:id])
  end
end
