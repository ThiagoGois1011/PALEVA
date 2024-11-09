class EstablishmentsController < ApplicationController
  before_action :check_if_exist_establishment, only: [:new, :create]
  skip_before_action :check_if_establishment_or_opening_hour_is_nil, only: [:new, :create]

  def new
    @establishment = Establishment.new
  end

  def create
    establishment_params = params.require(:establishment).permit(:corporate_name, :brand_name, :restration_number,
                                                                 :full_address, :phone_number, :email)
    @establishment = Establishment.new(establishment_params)
    @establishment.user_id = current_user.id

    if @establishment.save
      redirect_to new_establishment_opening_hour_path, notice: 'Estabelecimento cadastrado com sucesso.'
    else
      flash[:notice] = 'O estabelecimento não foi cadastrado.'
      render :new
    end
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