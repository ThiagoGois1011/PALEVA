class BeveragesController < ApplicationController

  def index
    @beverages = current_establishment.beverages
  end

  def new
    @beverage = Beverage.new
  end

  def create
    beverage_params = params.require(:beverage).permit(:name, :description, :calorie, :picture)

    @beverage = Beverage.new(beverage_params)
    @beverage.establishment = current_establishment

    @beverage.save!
    redirect_to establishment_beverage_path(@beverage), notice: 'Bebida cadastrada com sucesso.'
  end

  def edit
    @beverage = current_establishment.beverages.find(params[:id])
  end

  def update
    beverage_params = params.require(:beverage).permit(:name, :description, :calorie, :picture)
    @beverage = Beverage.find(params[:id])
    @beverage.update(beverage_params)
    redirect_to establishment_beverage_path(@beverage)
  end

  def destroy
    current_establishment.beverages.destroy(params[:id])
    redirect_to establishment_beverages_path
  end

  def show
    @beverage = current_establishment.beverages.find(params[:id])
    @portions = @beverage.portions
  end

  def status
    beverage = Beverage.find(params[:id])

    if beverage.active?
      beverage.disabled!
    else
      beverage.active!
    end

    redirect_to establishment_beverage_path(params[:id])
  end
end