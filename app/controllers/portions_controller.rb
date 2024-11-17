class PortionsController < ApplicationController

  def new
    if params[:dish_id].present?
      @product = current_establishment.dishes.find(params[:dish_id])
    else params[:beverage_id].present?
      @product = current_establishment.beverages.find(params[:beverage_id])
    end

    @portion = Portion.new
  end

  def create
    @establishment = current_establishment
    path_for_redirect = ''
    if params[:dish_id].present?
      @product = current_establishment.dishes.find(params[:dish_id])
      path_for_redirect = establishment_dish_path(@product)
    else params[:beverage_id].present?
      @product = current_establishment.beverages.find(params[:beverage_id])
      path_for_redirect = establishment_beverage_path(@product)
    end
    portion_params = params.require(:portion).permit(:description, :price)
    @portion = @product.portions.new(portion_params)

    save_model(model: @portion, notice_sucess: 'Porção cadastrada com sucesso.', 
               notice_failure: 'Porção não cadastrada.', redirect_url: path_for_redirect)
  end

  def edit
    if params[:dish_id].present?
      @product = current_establishment.dishes.find(params[:dish_id])
    else params[:beverage_id].present?
      @product = current_establishment.beverages.find(params[:beverage_id])
    end
    
    @portion = @product.portions.find(params[:id])
  end

  def update
    @establishment = current_establishment
    path_for_redirect = ''
    if params[:dish_id].present?
      @product = current_establishment.dishes.find(params[:dish_id])
      path_for_redirect = establishment_dish_path(params[:dish_id])
    else params[:beverage_id].present?
      @product = current_establishment.beverages.find(params[:beverage_id])
      path_for_redirect = establishment_beverage_path(params[:beverage_id])
    end
    portion_params = params.require(:portion).permit(:price)
    @portion = @product.portions.find(params[:id])
    @portion.historicals.create!(date_of_change: DateTime.now, price: @portion.price)

    update_model(model: @portion, update_params: portion_params,  notice_sucess: 'Porção editada com sucesso.', 
                 notice_failure: 'Porção não foi editada.', redirect_url: path_for_redirect)
  end
end