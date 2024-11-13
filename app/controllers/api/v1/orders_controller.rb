class Api::V1::OrdersController < Api::V1::ApiController

  def index 
    establishment = Establishment.find_by(code: params[:establishment_code])
    orders = nil

    if params[:status].present? && Order.statuses.include?(params[:status])
      orders = Order.where(establishment: establishment, status: params[:status])
    else
      orders = establishment.orders
    end

    return render status: 200, json: orders
    render status: 404, json: '{"error": "Estabelecimento não encontrado."}'
  end

  def show
    establishment = Establishment.find_by(code: params[:establishment_code])
    order = establishment.orders.find_by(code: params[:code])
    order_json = order.as_json(
      include: { 
        order_items: { 
          include: {
            portion: {
              include: :portionable 
            }
          } 
        } 
      }, 
      methods: :total_to_pay
    )

    render status: 200, json: order_json
  end

end