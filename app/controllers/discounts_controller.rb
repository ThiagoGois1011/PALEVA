class DiscountsController < ApplicationController
  def index
    @discounts = current_establishment.discounts
  end

  def show
    @discount = current_establishment.discounts.find(params[:id])
  end

  def new
    @discount = Discount.new
    dishes = current_establishment.dishes.flat_map do |dish|
      itens = []
      dish.portions.each do |portion|
        itens << {name: dish.name + " - " + portion.description, id: portion.id }
      end
      itens
    end
    beverages = current_establishment.beverages.flat_map do |beverage|
      itens = []
      beverage.portions.each do |portion|
        itens << {name: beverage.name + " - " + portion.description, id: portion.id }
      end
      itens
    end
    @products = { dishes: dishes, beverages: beverages}
  end

  def create
    params_discount = params.require(:discount).permit(:name, :discount_percentage, :start_date, :end_date, :limit)
    @discount = Discount.new(**params_discount, establishment: current_establishment)

    if @discount.save
      select_items = params[:discount][:select_items]
      if !select_items.nil?
        select_items.each do |chave, valor|
          @discount.portion_discounts.create(portion_id: valor)
        end
      end

      redirect_to establishment_discount_path(@discount), notice: 'Desconto cadastrado com sucesso.'
    else
      dishes = current_establishment.dishes.flat_map do |dish|
        itens = []
        dish.portions.each do |portion|
          itens << {name: dish.name + " - " + portion.description, id: portion.id }
        end
        itens
      end
      beverages = current_establishment.beverages.flat_map do |beverage|
        itens = []
        beverage.portions.each do |portion|
          itens << {name: beverage.name + " - " + portion.description, id: portion.id }
        end
        itens
      end
      @products = { dishes: dishes, beverages: beverages}
      flash.now[:notice] = 'Desconto não foi cadastrado.'
      render :new
    end
  end
end