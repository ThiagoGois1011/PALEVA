class OrderItemsController < ApplicationController
  skip_before_action :check_current_user_type_for_page
  
  def new
    @order_item = OrderItem.new
    @menu = params[:menu_id]
    @previous_url = request.referrer
    @portion = params[:portion_id]
    @order = current_order.id
  end

  def create
    order_items_params = params.require(:order_item).permit(:observation, :portion_id, :order_id)

    @order_item = OrderItem.create!(order_items_params)

    redirect_to params[:order_item][:previous_url], notice: 'Porção adicionado com sucesso.'
  end
end