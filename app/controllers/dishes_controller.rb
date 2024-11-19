class DishesController < ApplicationController

  def index
    @dishes = current_establishment.dishes
    @markers = current_establishment.markers
  end

  def new
    @dish = Dish.new
    @markers = current_establishment.markers
  end

  def filter
    @dishes = current_establishment.dishes.where(marker_id: params[:marker])
    @markers = current_establishment.markers
  end

  def create
    dish_params = params.require(:dish).permit(:name, :description, :calorie, :picture)

    @dish = Dish.new(dish_params)
    @dish.establishment = current_establishment

    value_select = params[:dish][:marker_select]
    create_value = params[:dish][:marker_create_check_box]
    input_for_create = params[:dish][:marker_create]

    if create_value == '0'
      @dish.marker_id = value_select
    else
      @input_marker = Marker.new(description: input_for_create, establishment: current_establishment)
    end

    if @input_marker.nil? && @dish.save
      redirect_to establishment_dish_path(@dish), notice: 'Prato cadastrado com sucesso.'
    elsif @input_marker.nil? && !@dish.save
      flash.now[:notice] = 'Prato não cadastrado.'
      render :new
    elsif @input_marker.save && @dish.save
      @dish.update(marker: @input_marker)
      redirect_to establishment_dish_path(@dish), notice: 'Prato cadastrado com sucesso.'
    else
      @errors_from_marker = @input_marker.errors.full_messages.map { |erro| 'Marcador: ' + erro}
      
      flash.now[:notice] = 'Prato não cadastrado.'
      render :new
    end
  end

  def edit
    @dish = current_establishment.dishes.find(params[:id])
    @markers = current_establishment.markers
  end

  def update
    dish_params = params.require(:dish).permit(:name, :description, :calorie, :picture)
    @dish = current_establishment.dishes.find(params[:id])

    value_select = params[:dish][:marker_select]
    create_value = params[:dish][:marker_create_check_box]
    input_for_create = params[:dish][:marker_create]

    if create_value == '0'
      @dish.marker_id = value_select
    else
      @input_marker = Marker.new(description: input_for_create, establishment: current_establishment)
    end

    if @input_marker.nil? && @dish.update(dish_params)
      redirect_to establishment_dish_path(@dish), notice: 'Prato editado com sucesso.'
    elsif @input_marker.nil? && !@dish.update(dish_params)
      flash.now[:notice] = 'Prato não editado.'
      render :edit
    elsif @input_marker.save && @dish.update(dish_params)
      @dish.update(marker: @input_marker)
      redirect_to establishment_dish_path(@dish), notice: 'Prato editado com sucesso.'
    else
      @errors_from_marker = @input_marker.errors.full_messages.map { |erro| 'Marcador: ' + erro}
      
      flash.now[:notice] = 'Prato não foi editado.'
      render :new
    end
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