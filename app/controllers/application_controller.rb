class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_if_establishment_is_nil, unless: :devise_controller?
  before_action :authenticate_user!
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf])
  end

  def check_if_establishment_is_nil
    redirect_to new_establishment_path if user_signed_in? && current_user.establishment.nil?
  end

  def after_sign_in_path_for(resource)
    if resource.establishment.nil?
      new_establishment_path
    else
      establishment_path(resource.establishment.id)
    end
  end

  # Redireciona após o cadastro
  def after_sign_up_path_for(resource)
    new_establishment_path
  end
end
