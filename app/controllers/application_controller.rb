class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_if_establishment_or_opening_hour_is_nil, unless: :devise_controller?
  before_action :authenticate_user!
  before_action :check_current_user_type_for_page, unless: :devise_controller?
  helper_method :current_establishment, :current_order
  # rescue_from   ActiveRecord::RecordNotFound, with: :not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf, :type])
  end

  def check_if_establishment_or_opening_hour_is_nil
    redirect_to new_establishment_path if user_signed_in? && current_establishment.nil?
    redirect_to new_establishment_opening_hour_path if user_signed_in? && 
                                                       !current_establishment.nil? &&
                                                       current_establishment.opening_hours.length < 6
  end

  def after_sign_in_path_for(resource)
    if resource.establishment.nil?
      new_establishment_path
    else
      establishment_menus_path
    end
  end

  def after_sign_up_path_for(resource)
    new_establishment_path
  end

  def current_establishment
    current_user.establishment
  end

  def current_order
    current_user.current_order
  end

  def check_current_user_type_for_page
    redirect_to establishment_menus_path, notice: 'Você não tem permissão de entrar nesta página.' unless current_user.type == 'Owner'
  end

  def not_found
    redirect_to request.referrer, notice: 'Objeto não existe.'
  end

  def save_model(model:, notice_sucess:, notice_failure:, redirect_url: )
    if model.save
      redirect_to redirect_url.sub('0', model.id.to_s), notice: notice_sucess
    else
      flash.now[:notice] = notice_failure
      render :new
    end
  end

  def update_model(model:, update_params:,  notice_sucess:, notice_failure:, redirect_url: )
    if model.update(update_params)
      redirect_to redirect_url.sub('0', model.id.to_s), notice: notice_sucess
    else
      flash.now[:notice] = notice_failure
      render :edit
    end
  end
end
