class PortionsController < ApplicationController
  def new
    @establishment = Establishment.find(params[:establishment_id])
    @dish = Dish.find(params[:dish_id])
    @portion = Portion.new
  end

  def create
    @establishment = Establishment.find(params[:establishment_id])
    @dish = Dish.find(params[:dish_id])
    portion_params = params.require(:portion).permit(:description, :price)
    @portion = @dish.portions.new(portion_params)
    @portion.save!

    redirect_to establishment_dish_path(establishment_id: params[:establishment_id], id: params[:dish_id])
  end
end