class Api::Admin::UsersController < Api::AdminController

  def index
    authorize!(:manage, :admin)
    @users = User.active.order(:email)
  end

  def create
    @user = User.create(
      :first_name => params['user']['first_name'],
      :last_name => params['user']['last_name'],
      :email => params['user']['email'],
      :password => 'kombucha',
      :password_confirmation => 'kombucha'
    )
    if @user.valid?
      render :partial => "api/admin/users/user.json", :locals => { :user => @user }
    else
      respond_with @user.errors, :location => api_users_path
    end
  end

  def update
    authorize!(:manage, :admin)
    user = User.find(params[:user][:id])
    user.email = params[:user][:email]
    user.roles = params[:user][:roles]
    respond_with :api, user.save
  end

  def destroy
    authorize!(:manage, :admin)
    user = User.find(params[:id])
    user.active = false
    user.save
    render :json => {:success => true}
  end

end