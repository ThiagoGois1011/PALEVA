class MenusController < ApplicationController
  skip_before_action :check_current_user_type_for_page, only: [:index, :show]

  def index
    @menus = current_establishment.menus
  end

  def new
    @menu = Menu.new
    dishes = current_establishment.dishes
    beverages = current_establishment.beverages
    @product = { dishes: dishes, beverages: beverages}
  end

  def create
    params_menu = params[:menu]
    @menu = Menu.new(name: params_menu[:name], establishment: current_establishment)

    if @menu.save
      if !params_menu[:select_items].nil?
        params_menu[:select_items].each do |chave, valor|
          valor_dividido = valor.split('_')
          if !MenuItem.find_by(menu: @menu, item_type: valor_dividido[0], item_id: valor_dividido[1])
            @menu.menu_items.create(item_type: valor_dividido[0] , item_id: valor_dividido[1])
          end
        end
      end

      redirect_to establishment_menu_path(@menu), notice: 'Cardápio cadastrado com sucesso.'
    else
      dishes = current_establishment.dishes
      beverages = current_establishment.beverages
      @product = { dishes: dishes, beverages: beverages}
      flash.now[:notice] = 'Cardápio não foi cadastrado.'
      render :new
    end
  end

  def show
    @menu = current_establishment.menus.find(params[:id])
  end
end