class Api::BatchCarbonationSettingsController < ApplicationController
  before_action :set_batch_carbonation_setting, only: [:show, :destroy]


  def index
    current_batch = Batch.find(params[:batch_id])
    if current_batch.batch_carbonation_settings.size > 0
      @batch_carbonation_settings = current_batch.batch_carbonation_settings
    else
      old_batch = Batch.order('brew_date DESC').where(:flavor_id => current_batch.flavor_id).select { |batch| batch.batch_carbonation_settings.size > 0 }.first
      BatchCarbonationSetting::KINDS.map { |kind|
        setting = old_batch.batch_carbonation_settings.where(:kind => kind[:kind_id]).first if old_batch
        current_batch.batch_carbonation_settings.create(
          :batch_id => current_batch.id,
          :kind => kind[:kind_id],
          :quantity => setting.try(:quantity) || 0,
          :unit => setting.try(:unit) || kind[:unit]
        )
      }
      @batch_carbonation_settings = current_batch.batch_carbonation_settings
    end
  end

  def show
  end

  def new
    @batch_carbonation_setting = BatchCarbonationSetting.new
  end

  def edit
  end

  def create
    @batch_carbonation_setting = BatchCarbonationSetting.new(params[:batch_carbonation_setting])
    @batch_carbonation_setting.save
    render :partial => "api/batch_carbonation_settings/batch_carbonation_setting.json", :locals => { :batch_carbonation_setting => @batch_carbonation_setting }
  end

  def update
    @batch_carbonation_setting.update_attributes(params[:batch_carbonation_setting])
    render :partial => "api/batch_carbonation_settings/batch_carbonation_setting.json", :locals => { :batch_carbonation_setting => @batch_carbonation_setting }
  end

  def destroy
    @batch_carbonation_setting.destroy
  end

  def update_quantity
    @batch_carbonation_setting = BatchCarbonationSetting.create_or_update_from_hash({
      :batch_id => params[:batch_id],
      :kind => params[:kind],
      :quantity => params[:quantity]
      })
    render :partial => "api/batch_carbonation_settings/batch_carbonation_setting.json", :locals => { :batch_carbonation_setting => @batch_carbonation_setting }
  end

  private

  def set_batch_carbonation_setting
    @batch_carbonation_setting = BatchCarbonationSetting.find(params[:id])
  end

  def batch_carbonation_setting_params
    params.require(:batch_carbonation_setting).permit(:id, :kind, :quantity, :unit)
  end

end
