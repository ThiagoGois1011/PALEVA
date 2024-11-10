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
      flash.now[:notice] = 'Pedido não registrado'
      render :new
    end
  end

  def confirm_order
  end

  def finalize
    current_order.update!(code: Order.generate_code, user_id: nil, status: :waiting_for_confirmation)
    
    redirect_to establishment_menus_path
  end

  def continue_order
    @orders = current_establishment.orders.creating_order
    @previous_url = request.referrer
  end

  def change_current_order
    if !current_order.nil?
      current_order.update(user: nil)
    end
    
    order = Order.find(params[:open_orders])
    order.update(user: current_user)

    redirect_to params[:previous_url], notice: 'Pedido selecionado com sucesso.'
  end
end