class Api::AerationsController < ApplicationController
  before_filter :determine_scope, :only => [:index]
  def index
    @aerations = @scope.all
  end

  def edit
    @aeration = Aeration.find(params[:id])
  end

  def update
  end

  def create
    @aeration = Aeration.new(params[:aeration])
    @aeration.save
    render :partial => "api/aerations/aeration.json", :locals => { :aeration => @aeration }
  end

  def update
    @aeration = Aeration.find(params[:id])
    params[:aeration][:reading_date] =  Time.strptime(params[:aeration][:reading_date], "%m/%d/%Y")
    @aeration.update_attributes(params[:aeration])
    render :partial => "api/aerations/aeration.json", :locals => { :aeration => @aeration }
  end

  def destroy
    @aeration = Aeration.find(params[:id])
    @aeration.destroy
    render :partial => "api/aerations/aeration.json", :locals => { :aeration => @aeration }
  end

  protected

  def determine_scope
    @scope = if params[:batch_id]
      Batch.find(params[:batch_id]).aerations
    else
      Batch
    end
  end


end
