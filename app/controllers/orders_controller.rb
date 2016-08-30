# Orders controller
class OrdersController < ApplicationController
  before_action :set_order, only: [:add, :pay]

  def index
    @orders = Order.all

    render json: @orders
  end

  def create
    @table = Table.find(params[:table_id])
    @order = @table.orders.build(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def add
    order_item = @order.build_new_item(order_item_params)

    if order_item.save
      render json: order_item, status: :created
    else
      render json: order_item.errors, status: :unprocessable_entity
    end
  end

  def pay
    amount = @order.total_amount
    if amount == params[:amount]
      @receipt = Receipt.new(order: @order,
                             payment_method: params[:payment_method])
      if @receipt.save
        render json: @receipt, staus: 204 # no content
      else
        render json: @receipt.errors, status: :unprocessable_entity
      end
    else
      render json: { 'message' => "You didn't pay for the exact amount #{amount}" },
             status: 422
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :email, :table_id)
  end

  def order_item_params
    params.permit(:item_id)
  end

  def item_id
    params[:item_id]
  end
end
