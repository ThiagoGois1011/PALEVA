class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_if_establishment_is_nil

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf])
  end

  def check_if_establishment_is_nil
    redirect_to new_establishment_path if user_signed_in? && current_user.establishment.nil? && 
                                          request.original_url != new_establishment_url && 
                                          request.original_url != establishment_index_url
  end
end
