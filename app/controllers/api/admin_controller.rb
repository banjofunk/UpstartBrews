class Api::AdminController < Api::BaseController

  def users
    authorize!(:manage, :admin)
    @users = User.active.order(:email)
  end

  def update_user
    authorize!(:manage, :admin)
    user = User.find(params[:user][:id])
    user.email = params[:user][:email]
    user.roles = params[:user][:roles]
    respond_with :api, user.save
  end

  def delete_user
    authorize!(:manage, :admin)
    user = User.find(params[:id])
    user.active = false
    user.save
    render :json => {:success => true}
  end

end