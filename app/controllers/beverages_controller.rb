class BeveragesController < ApplicationController

  def index
    @beverages = current_establishment.beverages
  end

  def new
    @beverage = Beverage.new
  end

  def create
    beverage_params = params.require(:beverage).permit(:name, :description, :calorie, :picture, :alcoholic)

    @beverage = Beverage.new(beverage_params)
    @beverage.establishment = current_establishment

    save_model(model: @beverage, notice_sucess: 'Bebida cadastrada com sucesso.', 
               notice_failure: 'Bebida não cadastrada.', redirect_url: establishment_beverage_path(0))
  end

  def edit
    @beverage = current_establishment.beverages.find(params[:id])
  end

  def update
    beverage_params = params.require(:beverage).permit(:name, :description, :calorie, :picture, :alcoholic)
    @beverage = current_establishment.beverages.find(params[:id])

    update_model(model: @beverage, update_params: beverage_params,  notice_sucess: 'Bebida editada com sucesso.', 
                 notice_failure: 'Bebida não editada.', redirect_url: establishment_beverage_path(0))
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
    beverage = current_establishment.beverages.find(params[:id])

    if beverage.active?
      beverage.disabled!
    else
      beverage.active!
    end

    redirect_to establishment_beverage_path(params[:id])
  end
end