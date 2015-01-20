class Api::CirculationsController < ApplicationController
  before_filter :determine_scope, :only => [:index]
  def index
    @circulations = @scope.all
  end

  def edit
    @circulation = Circulation.find(params[:id])
  end

  def update
  end

  protected

  def determine_scope
    @scope = if params[:batch_id]
      Batch.find(params[:batch_id]).circulations
    else
      Batch
    end
  end


end
