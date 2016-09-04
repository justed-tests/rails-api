require 'test_helper'

# test them all
class OrdersTest < MiniTest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    Rails.application
  end

  test 'can be paid' do
    table = spawn_table!
    order = spawn_order! table_id: table.id
    Item.create(id: 1, name: 'lol')
    2.times { order.order_items.create! item_id: 1 }

    post "/tables/#{table.id}/orders/#{order.id}/pay",
         amount: order.total_amount,
         payment_method: 'cash'

    assert_includes response_hash(last_response).keys, 'receipt'
  end
end
