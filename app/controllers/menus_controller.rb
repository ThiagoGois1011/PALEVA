class MenusController < ApplicationController
  def index
  end

  def new
    @establishment = current_user.establishment
    @menu = Menu.new
    dishes = @establishment.dishes
    beverages = @establishment.beverages
    @product = { dishes: dishes, beverages: beverages}
  end

  def create
    params_menu = params[:menu]
    @menu = Menu.create!(name: params_menu[:name])

    params_menu[:select_items].each do |chave, valor|
      valor_dividido = valor.split('_')
      @menu.menu_items.create(item_type: valor_dividido[0] , item_id: valor_dividido[1])
    end

    redirect_to establishment_menu_path(establishment_id: current_user.establishment, id: @menu)
  end

  def show
    @menu = Menu.find(params[:id])
  end
end