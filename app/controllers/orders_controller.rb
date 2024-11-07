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
end