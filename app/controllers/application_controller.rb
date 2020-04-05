class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  before_action :configure_devise_params, if: :devise_controller?
  before_action :set_feedback
  # skip_before_action :verify_authenticity_token
  layout :layout_by_resource

  ##
  # => Allow more parameters to user details
  #
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :username, :email, :password, :password_confirmation, :current_password) }
  end

  def default_url_options
    if Rails.env.production?
      {
        :host => "ariip.com",
        :protocol => 'https://'
      }
    else
      {}
    end
  end

  ##
  # Set a new feedback variable for form on all application pages
  def set_feedback
    @feedback = Feedback.new
    @client = Client.new
  end

  protected

  def layout_by_resource
    if devise_controller?

      if controller_name == 'registrations' && action_name == 'new'
        'home'
      elsif controller_name == 'registrations' && action_name == 'create'
        'home'
      elsif controller_name == 'sessions' && action_name == 'new'
        'home'
      elsif controller_name == 'registrations' && action_name == 'edit'
        'application'
      else
        'home'
      end
    end
  end
end
