class Api::BatchProcessesController < ApplicationController
  before_filter :determine_scope, :only => [:index]
  def index
    @batch_processes = @scope.all
  end

  def edit
    @batch_process = BatchProcess.find(params[:id])
  end

  def update
  end

  def create
    @batch_process = BatchProcess.new(params[:batch_process])
    @batch_process.save
    render :partial => "api/batches/process.json", :locals => { :batch_process => @batch_process }
  end

  def update
    @batch_process = BatchProcess.find(params[:id])
    params[:batch_process][:reading_date] =  Time.strptime(params[:batch_process][:reading_date], "%m/%d/%Y")
    @batch_process.update_attributes(params[:batch_process])
    render :partial => "api/batches/process.json", :locals => { :batch_process => @batch_process }
  end

  def destroy
    @batch_process = BatchProcess.find(params[:id])
    @batch_process.destroy
    render :partial => "api/batches/process.json", :locals => { :batch_process => @batch_process }
  end

  protected

  def determine_scope
    @scope = if params[:batch_id]
      Batch.find(params[:batch_id]).processes
    else
      Batch
    end
  end


end
