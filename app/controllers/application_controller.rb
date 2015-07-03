class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
 
  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  def downgrade
    current_user.update_attribute(:role, 'free')
    current_user.wikis.update_all(:private => 'false')
    flash[:notice] = "You have successfully downgraded."
    redirect_to new_charge_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

end
