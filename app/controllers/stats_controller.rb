# some statistics
class StatsController < ApplicationController
  def index
    render json: {
      orders: orders,
      customers: customers,
      orders_by_month: orders_by_month
    }
  end

  private

  def orders
    @orders ||= Order.all
  end

  def customers
    orders.group_by(&:name).map do |name, orders|
      [name, orders.count]
    end
  end

  def orders_by_month
    groups = orders.group_by do |order|
      order.created_at.beginning_of_month
    end
    groups.map do |month, orders|
      [month, orders.count]
    end
  end
end
