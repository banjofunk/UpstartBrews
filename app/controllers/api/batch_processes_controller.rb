class Api::BatchProcessesController < ApplicationController
  load_and_authorize_resource

  before_filter :determine_scope, :only => [:index, :end_batch_process]

  def index


    if params[:category] == 'all'
      @process_types = {}
      ProcessType::CATEGORIES.each do |category|
        @process_types[category] = ProcessType.category(category)
      end
      if can? :manage, BatchProcess
        @batch_processes = @scope.joins(:process_type).order_kind
      else
        @batch_processes = @scope.secured.joins(:process_type).order_kind

      end
    else
      @process_types = {params[:category] => ProcessType.category(params[:category])}
      if can? :manage, BatchProcess
        @batch_processes = @scope.category(params[:category]).joins(:process_type).order_kind
      else
        @batch_processes = @scope.category(params[:category]).secured.joins(:process_type).order_kind
      end
    end

  end

  def show
    @batch_processes = BatchProcess.find(params[:id])
  end

  def edit
    @batch_process = BatchProcess.find(params[:id])
  end

  def create
    @batch_process = BatchProcess.new(params[:batch_process])
    @batch_process.save
    render :partial => "api/batch_processes/batch_process.json", :locals => { :batch_process => @batch_process }
  end

  def update
    params.permit!
    params[:batch_process][:started] =  Time.strptime(params[:started], "%m/%d at %I:%M %p")
    params[:batch_process][:stopped] =  Time.strptime(params[:stopped], "%m/%d at %I:%M %p") if params[:stopped]
    @batch_process = BatchProcess.find(params[:process_id])
    @batch_process.update_attributes(params[:batch_process])
    render :partial => "api/batch_processes/batch_process.json", :locals => { :batch_process => @batch_process }
  end

  def destroy
    @batch_process = BatchProcess.find(params[:id])
    @batch_process.destroy
    currently_on = Batch.find(params[:batch_id]).batch_processes.kind(@batch_process.process_type.name).current.count > 0
    render :json => currently_on
  end

  def start_batch_process
    params.permit!
    process_type_id = ProcessType.find_by_name(params[:process_type]).id
    @batch_process = BatchProcess.create(:batch_id => params[:batch_id], :process_type_id => process_type_id, :started => Time.current)
    render :show
  end

  def end_batch_process
    params.permit!
    @batch_process = @scope.current.kind(params[:kind]).last
    @batch_process.stopped = Time.current
    @batch_process.save
    render :show
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
