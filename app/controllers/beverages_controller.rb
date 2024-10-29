class BeveragesController < ApplicationController
  before_action :check_current_user

  def index
    @beverages = Establishment.find(params[:establishment_id]).beverages
  end

  def new
    @beverage = Beverage.new
  end

  def create
    beverage_params = params.require(:beverage).permit(:name, :description, :calorie, :picture)

    @beverage = Beverage.new(beverage_params)
    @beverage.establishment = Establishment.find(params[:establishment_id])

    @beverage.save!
    redirect_to establishment_beverage_path(establishment_id: params[:establishment_id], id: @beverage.id), notice: 'Bebida cadastrada com sucesso.'
  end

  def edit
    @beverage = Establishment.find(params[:establishment_id]).beverages.find(params[:id])
  end

  def update
    beverage_params = params.require(:beverage).permit(:name, :description, :calorie, :picture)
    @beverage = Beverage.find(params[:id])
    @beverage.update(beverage_params)
    redirect_to establishment_beverage_path(establishment_id: @beverage.establishment.id, id: @beverage.id)
  end

  def destroy
    Establishment.find(params[:establishment_id]).beverages.destroy(params[:id])
    redirect_to establishment_beverages_path(params[:establishment_id])
  end

  def show
    @beverage = current_user.establishment.beverages.find(params[:id])
  end

  def status
    beverage = Beverage.find(params[:id])

    if beverage.active?
      beverage.disabled!
    else
      beverage.active!
    end

    redirect_to establishment_beverage_path(establishment_id: params[:establishment_id], id: params[:id])
  end

  private

  def check_current_user
    redirect_to establishment_path(current_user.establishment.id), notice: 'Você não tem permissão de ver essa página' if Integer(params[:establishment_id]) != current_user.establishment.id
  end
end