class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
    before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :add_role_to_cookies, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:photo, :photo_cache, :role, :first_name, :last_name, :bio])
  end

  def add_role_to_cookies
    if params[:role].present?
      session[:role] = params[:role]
    end
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
end
