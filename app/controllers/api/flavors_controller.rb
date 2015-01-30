class Api::FlavorsController < ApplicationController
  def index
    @flavors = Flavor.all
  end

  def show
    @flavor = Flavor.find(params[:id])
  end

  def edit
    @flavor = Flavor.find(params[:id])
  end

  def update
  end
end
