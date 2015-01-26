class Api::InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]
  before_action :determine_scope, only: [:index]


  def index
    @inventories = @scope.by_package_type
  end

  def show
  end

  def new
    @inventory = Inventory.new
  end

  def edit
  end

  def create
    @inventory = Inventory.create_or_update_from_hash(params)
  end

  def update
  end

  def update_quantity
    @inventory = Inventory.find(params[:inventory_id])
    @inventory.quantity = params[:quantity]
    @inventory.save
    render :partial => "api/inventories/inventory.json", :locals => { :inventory => @inventory }
  end

  def destroy
    @inventory.destroy
  end

  protected

  def determine_scope
    @scope = if params[:batch_id]
      Batch.find(params[:batch_id]).inventories
    else
      Inventory
    end
  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  private

  def batch_reading_params
    params.require(:batch_reading).permit(:id, :batch_id, :quantity, :package_type_id)
  end

end
