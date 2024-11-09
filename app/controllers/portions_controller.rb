class PortionsController < ApplicationController
  def new
    @establishment = current_establishment
    if params[:dish_id].present?
      @product = Dish.find(params[:dish_id])
    else params[:beverage_id].present?
      @product = Beverage.find(params[:beverage_id])
    end
    
    @portion = Portion.new
  end

  def create
    @establishment = current_establishment
    path_for_redirect = ''
    if params[:dish_id].present?
      @product = Dish.find(params[:dish_id])
      path_for_redirect = establishment_dish_path( id: params[:dish_id])
    else params[:beverage_id].present?
      @product = Beverage.find(params[:beverage_id])
      path_for_redirect = establishment_beverage_path( id: params[:beverage_id])
    end
    portion_params = params.require(:portion).permit(:description, :price)
    @portion = @product.portions.new(portion_params)
    @portion.save!

    
    redirect_to path_for_redirect
  end

  def edit
    @establishment = current_establishment
    if params[:dish_id].present?
      @product = Dish.find(params[:dish_id])
    else params[:beverage_id].present?
      @product = Beverage.find(params[:beverage_id])
    end
    @portion = Portion.find(params[:id])
  end

  def update
    @establishment = current_establishment
    path_for_redirect = ''
    if params[:dish_id].present?
      @product = Dish.find(params[:dish_id])
      path_for_redirect = establishment_dish_path( id: params[:dish_id])
    else params[:beverage_id].present?
      @product = Beverage.find(params[:beverage_id])
      path_for_redirect = establishment_beverage_path( id: params[:beverage_id])
    end
    portion_params = params.require(:portion).permit(:price)
    @portion = Portion.find(params[:id])
    @portion.historicals.create!(date_of_change: DateTime.now, price: @portion.price)
    @portion.update(portion_params)

    redirect_to path_for_redirect
  end
end