class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :permit_devise_parameters, if: :devise_controller?

  protected

  def permit_devise_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
   end
end
