class HistoricalsController < ApplicationController
  def index
    if params[:dish_id].present?
      @product = current_establishment.dishes.find(params[:dish_id])
    else params[:beverage_id].present?
      @product = current_establishment.beverages.find(params[:beverage_id])
    end
    @portion = @product.portions.find(params[:portion_id])
    @historicals = @portion.historicals
  end
end