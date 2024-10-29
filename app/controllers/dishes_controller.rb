class DishesController < ApplicationController
  before_action :check_current_user

  def index
    @dishes = Establishment.find(params[:establishment_id]).dishes
  end

  def new
    @dish = Dish.new
  end

  def create
    dish_params = params.require(:dish).permit(:name, :description, :calorie, :picture)

    @dish = Dish.new(dish_params)
    @dish.establishment = Establishment.find(params[:establishment_id])

    @dish.save!
    redirect_to establishment_dish_path(establishment_id: params[:establishment_id], id: @dish.id ), notice: 'Prato cadastrado com sucesso.'
  end

  def edit
    @dish = Establishment.find(params[:establishment_id]).dishes.find(params[:id])
  end

  def update
    dish_params = params.require(:dish).permit(:name, :description, :calorie, :picture)
    @dish = Dish.find(params[:id])
    @dish.update(dish_params)
    redirect_to establishment_dish_path(establishment_id: params[:establishment_id], id: @dish.id )
  end

  def destroy
    Establishment.find(params[:establishment_id]).dishes.destroy(params[:id])
    redirect_to establishment_dishes_path(params[:establishment_id])
  end

  def show
    @dish = current_user.establishment.dishes.find(params[:id])
  end

  def status
    dish = Dish.find(params[:id])

    if dish.active?
      dish.disabled!
    else
      dish.active!
    end

    redirect_to establishment_dish_path(establishment_id: params[:establishment_id], id: params[:id])
  end

  private

  def check_current_user
    redirect_to establishment_path(current_user.establishment.id), notice: 'Você não tem permissão de ver essa página' if Integer(params[:establishment_id]) != current_user.establishment.id
  end
end