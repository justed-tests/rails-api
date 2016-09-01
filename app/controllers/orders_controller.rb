# Orders controller
class OrdersController < ApplicationController
  require 'order_payer'
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
    service = OrderPayer.new(@order)
    service.pay params[:amount].to_i, params[:payment_method]
    if service.ok?
      render json: service.receipt, root: true, staus: 201 # no content
    else
      render json: service.message, status: :unprocessable_entity
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
