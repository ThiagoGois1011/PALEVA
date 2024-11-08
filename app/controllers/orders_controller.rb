class OrdersController < ApplicationController
  def new
    @order = Order.new
    @previous_url = request.referrer
  end

  def create
    order_params = params.require(:order).permit(:name, :cpf, :phone_number, :email)
    @order = Order.new(order_params)
    @order.establishment = current_user.establishment
    @order.user = current_user

    if @order.save
      redirect_to params[:order][:previous_url], notice: 'Pedido registrado com sucesso.'
    else
      flash.now[:notice] = 'Pedido não registrado'
      render :new
    end
  end

  def finalize
    order = current_user.establishment.orders.find(params[:id])
    order.update!(code: Order.generate_code, user_id: nil, status: :waiting_for_confirmation)
    
    redirect_to establishment_menus_path(current_user.establishment)
  end
end