class DishesController < ApplicationController

  def index
    @dishes = current_establishment.dishes
    @markers = Marker.all
  end

  def new
    @dish = Dish.new
    @markers = Marker.all
  end

  def filter
    @dishes = current_establishment.dishes.where(marker_id: params[:marker])
    @markers = Marker.all
  end

  def create
    dish_params = params.require(:dish).permit(:name, :description, :calorie, :picture)

    @dish = Dish.new(dish_params)
    @dish.establishment = current_establishment

    value_select = params[:dish][:marker_select]
    create_value = params[:dish][:marker_create]
    
    if create_value.empty?
      @dish.marker_id = value_select
    else
      @dish.marker = Marker.create!(description: create_value)
    end

    save_model(model: @dish, notice_sucess: 'Prato cadastrado com sucesso.', 
               notice_failure: 'Prato não cadastrado.', redirect_url: establishment_dish_path(0))
  end

  def edit
    @dish = current_establishment.dishes.find(params[:id])
    @markers = Marker.all
  end

  def update
    dish_params = params.require(:dish).permit(:name, :description, :calorie, :picture)
    @dish = Dish.find(params[:id])
    value_select = params[:dish][:marker_select]
    create_value = params[:dish][:marker_create]
    
    if create_value.empty?
      dish_params[:marker_id] = value_select
    else
      dish_params[:marker] = Marker.create!(description: create_value)
    end

    update_model(model: @dish, update_params: dish_params,  notice_sucess: 'Prato editado com sucesso.', 
                 notice_failure: 'Prato não editado.', redirect_url: establishment_dish_path(0))
  end

  def destroy
    current_establishment.dishes.destroy(params[:id])
    redirect_to establishment_dishes_path
  end

  def show
    @dish = current_establishment.dishes.find(params[:id])
    @portions = @dish.portions
  end

  def status
    dish = current_establishment.dishes.find(params[:id])

    if dish.active?
      dish.disabled!
    else
      dish.active!
    end

    redirect_to establishment_dish_path(params[:id])
  end

end