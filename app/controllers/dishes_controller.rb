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

    @dish.save!
    redirect_to establishment_dish_path(@dish), notice: 'Prato cadastrado com sucesso.'
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
    @dish.update(dish_params)
    redirect_to establishment_dish_path( id: @dish.id )
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
    dish = Dish.find(params[:id])

    if dish.active?
      dish.disabled!
    else
      dish.active!
    end

    redirect_to establishment_dish_path(params[:id])
  end

end