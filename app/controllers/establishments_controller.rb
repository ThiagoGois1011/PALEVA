class EstablishmentsController < ApplicationController
  before_action :check_if_exist_establishment, only: [:new, :create]
  skip_before_action :check_if_establishment_or_opening_hour_is_nil, only: [:new, :create]
  skip_before_action :check_current_user_type_for_page, only:[:show]

  def new
    @establishment = Establishment.new
  end

  def create
    establishment_params = params.require(:establishment).permit(:corporate_name, :brand_name, :restration_number,
                                                                 :full_address, :phone_number, :email)
    @establishment = Establishment.new(establishment_params)
    @establishment.user_id = current_user.id

    save_model(model: @establishment, notice_sucess: 'Estabelecimento cadastrado com sucesso.', 
                notice_failure: 'O estabelecimento não foi cadastrado.', redirect_url: new_establishment_opening_hour_path)
  end

  def show
    @establishment = current_establishment
  end

  def search
    establishment = current_establishment
    dishes = establishment.dishes.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    beverages = establishment.beverages.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    @result = [dishes, beverages].map(&:to_a).flatten
  end

  private 

  def check_if_exist_establishment
    redirect_to establishment_path, notice: 'Cada usuário só pode ter um estabelecimento cadastrado.' unless current_establishment.nil?
  end
end