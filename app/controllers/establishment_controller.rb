class EstablishmentController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_exist_establishment, only: [:new]
  
  def new
    @establishment = Establishment.new
  end

  def create
    establishment_params = params.require(:establishment).permit(:corporate_name, :brand_name, :restration_number,
                                                                 :full_address, :phone_number, :email)
    @establishment = Establishment.new(establishment_params)
    @establishment.code = '125478'
    @establishment.user_id = current_user.id

    if @establishment.save
      redirect_to @establishment, notice: 'Restaurante cadastrado com sucesso.'
    else
      flash[:notice] = 'Algo ocorreu'
      render :new
    end
  end

  def show
    @establishment = Establishment.find(params[:id])
  end

  def search
    establishment = current_user.establishment
    dishes = establishment.dishes.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    beverages = establishment.beverages.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    @result = [dishes, beverages].map(&:to_a).flatten
  end

  private 

  def check_if_exist_establishment
    redirect_to current_user.establishment, notice: 'Cada usuário só pode ter um estabelecimento cadastrado' unless current_user.establishment.nil?
  end
end