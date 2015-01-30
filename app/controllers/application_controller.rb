class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :set_csrf_cookie_for_ng
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def index
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, roles: [])}
  end

  # In Rails 4.2 and above
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  # In Rails 4.1 and below
  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      render :text => "not authorized", :status => 403, :layout => false
    else
      render :text => "sign in", :status => 403, :layout => false
    end
  end

end
