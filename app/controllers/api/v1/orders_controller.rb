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

end