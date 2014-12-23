class BatchesController < ApplicationController
  before_action :set_batch, only: [:show, :edit, :update, :destroy]

  def index
    @batches = Batch.all
  end

  def show
  end

  def new
    @batch = Batch.new
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
