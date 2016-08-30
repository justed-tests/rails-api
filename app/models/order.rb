# order for tables =)
class Order < ApplicationRecord
  belongs_to :table
  has_many :order_items
  has_many :items, through: :order_items

  def build_new_item(params)
    existing_item = OrderItem.find_by(order: self, item_id: params[:item_id])
    if existing_item
      existing_item.increment(:quantity)
    else
      order_items.build(params)
    end
  end

  def total_amount
    items.inject(0) do |sum, item|
      sum + item.price
    end
  end
end
