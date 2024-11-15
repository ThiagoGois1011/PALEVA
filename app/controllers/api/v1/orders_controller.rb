class Api::V1::OrdersController < Api::V1::ApiController
  before_action :find_establishment_and_order, except: [:index]

  def index 
    establishment = Establishment.find_by(code: params[:establishment_code])
    raise ActiveRecord::RecordNotFound, "Estabelecimento não encontrado." if establishment.nil?
    orders = nil

    if Order.statuses.include?(params[:status])
      orders = Order.where(establishment: establishment, status: params[:status])
    else
      orders = establishment.orders.where.not(status: :creating_order)
    end

    render status: 200, json: orders
  end

  def show
    order_json = @order.as_json(
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

  def accept_order
    if @order.status.eql?('waiting_for_confirmation')
      @order.in_preparation!

      render status: 200, json: @order
    else
      render status: 403, json: { error: 'Só é possível atualizar o status para "in_preparation" caso o status atual seja "waiting_for_confirmation"'}
    end
  end

  def ready
    if @order.status.eql?('in_preparation')
      @order.ready!

      render status: 200, json: @order
    else
      return render status: 403, json: { error: 'Só é possível atualizar o status para "ready" caso o status atual seja "in_preparation"' }
    end
  end

  private 

  def find_establishment_and_order
    @establishment = Establishment.find_by(code: params[:establishment_code])
    raise ActiveRecord::RecordNotFound, "Estabelecimento não encontrado." if @establishment.nil?
    @order = @establishment.orders.find_by(code: params[:code])
    raise ActiveRecord::RecordNotFound, "Pedido não encontrado." if @order.nil? || @order.status.eql?('creating_order')
  end

end