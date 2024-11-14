class Api::V1::OrdersController < Api::V1::ApiController

  def index 
    establishment = Establishment.find_by(code: params[:establishment_code])
    raise ActiveRecord::RecordNotFound, "Estabelecimento não encontrado." if establishment.nil?
    orders = nil

    if params[:status].present? && Order.statuses.include?(params[:status])
      orders = Order.where(establishment: establishment, status: params[:status])
    else
      orders = establishment.orders.where.not(status: :creating_order)
    end

    render status: 200, json: orders
  end

  def show
    establishment = Establishment.find_by(code: params[:establishment_code])
    raise ActiveRecord::RecordNotFound, "Estabelecimento não encontrado." if establishment.nil?
    order = establishment.orders.find_by(code: params[:code])
    raise ActiveRecord::RecordNotFound, "Pedido não encontrado." if order.nil? || order.status.eql?('creating_order')

    order_json = order.as_json(
      include: { 
        order_items: { 
          include: {
            portion: {
              include: {
                portionable: {
                  include: :marker
                }
              }
            }
          } 
        } 
      }, 
      methods: :total_to_pay
    )

    render status: 200, json: order_json
  end

end