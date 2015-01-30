class Api::BatchesController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :set_batch, only: [:show, :edit, :update, :destroy, :add_comment]
  load_and_authorize_resource :except => [:add_comment]


  def index
    if params['show_all']
      @batches = Batch.all
    else
      @batches = Fermenter.order('position ASC').map {|fermenter|
        batch = fermenter.batches.order('brew_date DESC').first
        if !batch
          batch = Batch.new(
            :state => Batch::DELETED,
            :flavor_id => fermenter.flavor_id,
            :fermenter_id => fermenter.id,
            :brew_date => Time.current,
            :created_at => Time.current
            )
          fermenter.update_attributes(:state => Fermenter::EMPTY)
        end
        batch
      }
    end
  end

  def show
  end

  def new
    @batch = Batch.new
  end

  def edit
  end

  def create
    @batch = Batch.new(params[:batch])
    @batch.brew_date = Time.current
    @batch.save
    @batch.fermenter.update_attributes(:state=>Fermenter::FULL)
    render :partial => "api/batches/batch.json", :locals => { :batch => @batch }
  end

  def update
    params.permit!
    params[:batch][:brew_date] =  Time.strptime(params[:batch][:brew_date], "%m/%d/%Y") if params[:batch][:brew_date]
    @batch.update_attributes(params[:batch])
    render :partial => "api/batches/batch.json", :locals => { :batch => @batch }
  end

  def destroy
    @batch.destroy
  end

  def add_comment
    comment = @batch.comments.create(:user => current_user, :text => params[:text])
    render :partial => "api/comments/comment.json", :locals => { :comment => comment }
  end

  def set_inventories
    batch = Batch.find(params[:batch_id])
    batch.inventories.each do |inventory|
      inventory.state = Inventory::ACTIVE
      inventory.save
    end
    render :partial => "api/batches/batch.json", :locals => { :batch => batch }
  end

  private

  def set_batch
    @batch = Batch.find(params[:id])
  end

  def batch_params
    params.require(:batch).permit(:id, :flavor_id, :fermenter_id, :brew_date)
  end

end
