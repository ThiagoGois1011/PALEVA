class OrdersController < ApplicationController
  skip_before_action :check_current_user_type_for_page

  def new
    @order = Order.new
    @previous_url = request.referrer
  end

  def create
    order_params = params.require(:order).permit(:name, :cpf, :phone_number, :email)
    @order = Order.new(order_params)
    @order.establishment = current_establishment
    if !current_order.nil?
      current_order.update(user: nil)
    end
    @order.user = current_user

    if @order.save
      redirect_to params[:order][:previous_url], notice: 'Pedido registrado com sucesso.'
    else
      @previous_url = params[:order][:previous_url]
      flash.now[:notice] = 'Pedido não registrado'
      render :new
    end
  end

  def confirm_order
  end

  def finalize
    current_order.portions.each do |portion|
      bigger_discount_value = 0 
      bigger_discount = nil
      portion.discounts.each do |discount|
        if discount.valid_date(Date.today) && discount.discount_percentage > bigger_discount_value  && discount.limit > discount.order_discounts.length
          bigger_discount_value = discount.discount_percentage
          bigger_discount = discount
        end
      end

      if bigger_discount.present?
        bigger_discount.order_discounts.create!(order: current_order)
      end
    end
    current_order.update!(code: Order.generate_code, user_id: nil, status: :waiting_for_confirmation, creation_date: DateTime.now)
    redirect_to establishment_menus_path
  end

  def continue_order
    @orders = current_establishment.orders.creating_order
    @previous_url = request.referrer
  end

  def change_current_order
    
    unless params[:open_orders].empty?
      if !current_order.nil?
        current_order.update(user: nil)
      end

      order = current_establishment.orders.find(params[:open_orders])
      order.update(user: current_user)
      redirect_to params[:previous_url], notice: 'Pedido selecionado com sucesso.'
    else
      redirect_to params[:previous_url], notice: 'Pedido não encontrado.'
    end
  end
end