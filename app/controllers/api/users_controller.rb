class Api::UsersController < Api::BaseController

  def show
    render :json => {:info => "Current User", :user => current_user}, :status => 200
  end

  def ability
    ability = Ability.new(current_user).as_json
    render :json => {:ability => ability, :roles => current_user.roles}
  end

  def roles
    render :json => current_user.roles
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      sign_in(@user)
      respond_with @user, :location => api_users_path
    else
      respond_with @user.errors, :location => api_users_path
    end
  end

  def update
    respond_with :api, User.update(current_user.id, user_params)
  end

  def destroy
    respond_with :api, User.find(current_user.id).destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end