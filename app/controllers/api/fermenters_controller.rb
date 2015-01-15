class Api::FermentersController < ApplicationController


  def sort
    sort = params['sort']
    sort.each_with_index do |ferm_id, idx|
      ferm = Fermenter.find(ferm_id)
      ferm.position = idx
      ferm.save
    end
    render :json => sort.to_json
  end

end
