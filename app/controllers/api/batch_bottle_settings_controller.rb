class Api::BatchBottleSettingsController < ApplicationController
  before_action :set_batch_bottle_setting, only: [:show, :update, :destroy]


  def index
    current_batch = Batch.find(params[:batch_id])
    @batch_bottle_settings = current_batch.batch_bottle_settings
  end

  def show
  end

  def new
    @batch_bottle_setting = BatchBottleSetting.new
  end

  def edit
  end

  def create
    @batch_bottle_setting = BatchBottleSetting.new(params[:batch_bottle_setting])
    @batch_bottle_setting.save
    render :partial => "api/batch_bottle_settings/batch_bottle_setting.json", :locals => { :batch_bottle_setting => @batch_bottle_setting }
  end

  def update
    @batch_bottle_setting.update_attributes(params[:batch_bottle_setting])
    render :partial => "api/batch_bottle_settings/batch_bottle_setting.json", :locals => { :batch_bottle_setting => @batch_bottle_setting }
  end

  def destroy
    @batch_bottle_setting.destroy
  end

  def update_quantity
    @batch_bottle_setting = BatchBottleSetting.create_or_update_from_hash({
      :batch_id => params[:batch_id],
      :kind => params[:kind],
      :quantity => params[:quantity]
      })
    render :partial => "api/batch_bottle_settings/batch_bottle_setting.json", :locals => { :batch_bottle_setting => @batch_bottle_setting }
  end

  private

  def set_batch_bottle_setting
    @batch_bottle_setting = BatchBottleSetting.find(params[:id])
  end

  def batch_bottle_setting_params
    params.require(:batch_bottle_setting).permit(:id, :kind, :quantity, :unit)
  end

end
