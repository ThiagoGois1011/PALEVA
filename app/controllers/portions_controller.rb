class PortionsController < ApplicationController
  def new
    @establishment = Establishment.find(params[:establishment_id])
    if params[:dish_id].present?
      @product = Dish.find(params[:dish_id])
    else params[:beverage_id].present?
      @product = Beverage.find(params[:beverage_id])
    end
    
    @portion = Portion.new
  end

  def create
    @establishment = Establishment.find(params[:establishment_id])
    path_for_redirect = ''
    if params[:dish_id].present?
      @product = Dish.find(params[:dish_id])
      path_for_redirect = establishment_dish_path(establishment_id: params[:establishment_id], id: params[:dish_id])
    else params[:beverage_id].present?
      @product = Beverage.find(params[:beverage_id])
      path_for_redirect = establishment_beverage_path(establishment_id: params[:establishment_id], id: params[:beverage_id])
    end
    portion_params = params.require(:portion).permit(:description, :price)
    @portion = @product.portions.new(portion_params)
    @portion.save!

    
    redirect_to path_for_redirect
  end

  def edit
    @establishment = Establishment.find(params[:establishment_id])
    @dish = Dish.find(params[:dish_id])
    @portion = Portion.find(params[:id])
  end

  def update
    @establishment = Establishment.find(params[:establishment_id])
    @dish = Dish.find(params[:dish_id])
    portion_params = params.require(:portion).permit(:price)
    @portion = Portion.find(params[:id])
    @portion.historicals.create!(date_of_change: DateTime.now, price: @portion.price)
    @portion.update(portion_params)

    redirect_to establishment_dish_path(establishment_id: params[:establishment_id], id: params[:dish_id])
  end
end