class MenusController < ApplicationController
  def index
    @menus = current_establishment.menus
  end

  def new
    @establishment = current_establishment
    @menu = Menu.new
    dishes = @establishment.dishes
    beverages = @establishment.beverages
    @product = { dishes: dishes, beverages: beverages}
  end

  def create
    params_menu = params[:menu]
    @establishment = current_establishment
    @menu = Menu.new(name: params_menu[:name], establishment: @establishment)

    if @menu.save
      params_menu[:select_items].each do |chave, valor|
        valor_dividido = valor.split('_')
        @menu.menu_items.create(item_type: valor_dividido[0] , item_id: valor_dividido[1])
      end

      redirect_to establishment_menu_path(@menu)
    else
      flash.now[:notice] = @menu.errors.full_messages[0]
      render :new
    end
  end

  def show
    @menu = Menu.find(params[:id])
  end
end