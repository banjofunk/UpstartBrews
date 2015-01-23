class Api::BatchProcessesController < ApplicationController
  before_filter :determine_scope, :only => [:index, :end_batch_process]


  def start_batch_process
    params.permit!
    batch_process = BatchProcess.create(:batch_id => params[:batch_id], :process_type => params[:process_type], :started => Time.current)
    render :partial => "api/batches/process.json", :locals => { :batch_process => batch_process }
  end

  def end_batch_process
    params.permit!
    batch_process = @scope.find(params[:process_id])
    batch_process.stopped = Time.current
    batch_process.save
    current_batch_processes = @scope.kind(params[:kind]).current
    current_batch_processes.update_all(:stopped => Time.current)
    render :partial => "api/batches/process.json", :locals => { :batch_process => batch_process }
  end


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
    params.permit!
    params[:batch_process][:started] =  Time.strptime(params[:started], "%m/%d at %I:%M %p")
    params[:batch_process][:stopped] =  Time.strptime(params[:stopped], "%m/%d at %I:%M %p")
    @batch_process = BatchProcess.find(params[:process_id])
    @batch_process.update_attributes(params[:batch_process])
    render :partial => "api/batches/process.json", :locals => { :batch_process => @batch_process }
  end

  def destroy
    @batch_process = BatchProcess.find(params[:process_id])
    @batch_process.destroy
    render :partial => "api/batches/process.json", :locals => { :batch_process => @batch_process }
  end

  protected

  def determine_scope
    @scope = if params[:batch_id]
      Batch.find(params[:batch_id]).batch_processes
    else
      Batch
    end
  end


end
