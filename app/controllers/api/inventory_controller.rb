class Api::InventoryController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]


  def index
    @inventories = Inventory.all
  end

  def show
  end

  def new
    @inventory = Inventory.new
  end

  def edit
  end

  def create
    @inventory = Inventory.new(params)
  end

  def update
  end

  def destroy
    @inventory.destroy
  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

end
