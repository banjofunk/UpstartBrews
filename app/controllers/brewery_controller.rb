class BreweryController < ApplicationController
  def index
    @batches = Batch.all
  end
end
