class Api::VentilationsController < ApplicationController
  before_filter :determine_scope, :only => [:index]
  def index
    @ventilations = @scope.all
  end

  def edit
    @ventilation = Ventilation.find(params[:id])
  end

  def update
  end

  protected

  def determine_scope
    @scope = if params[:batch_id]
      Batch.find(params[:batch_id]).ventilations
    else
      Batch
    end
  end


end
