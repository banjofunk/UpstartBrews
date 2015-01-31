class Api::FermentersController < ApplicationController
  load_and_authorize_resource

  def sort
    sort = params['sort']
    new_sort = []
    sort.each_with_index do |ferm_id, idx|
      ferm = Fermenter.find(ferm_id)
      ferm.position = idx
      ferm.save
      new_sort << {:id => ferm.id, :position => ferm.position}
    end
    render :json => new_sort.to_json
  end

  def set_fermenter_state
    fermenter = Fermenter.find(params[:id])
    state = "Fermenter::#{params[:state_name].upcase}".constantize
    fermenter.update_attributes(:state => state)
    render :partial => "api/fermenters/fermenter.json", :locals => { :fermenter => fermenter }
  end

end
