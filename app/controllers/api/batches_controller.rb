class Api::BatchesController < ApplicationController
  before_action :set_batch, only: [:show, :edit, :update, :destroy, :add_comment]
  load_and_authorize_resource :except => [:add_comment]


  def index
    if params['show_all']
      @batches = Batch.all
    else
      @batches = Fermenter.order('position ASC').map {|v| v.batches.order('brew_date DESC').first}
    end
  end

  def show
  end

  def new
    @batch = Batch.new
  end

  def add_comment
    comment = @batch.comments.create(:user => current_user, :text => params[:text])
    render :partial => "api/comments/comment.json", :locals => { :comment => comment }
  end

  def edit
  end

  def create
    @batch = Batch.new(params)
  end

  def update
  end

  def destroy
    @batch.destroy
  end

  private

  def set_batch
    @batch = Batch.find(params[:id])
  end

end
