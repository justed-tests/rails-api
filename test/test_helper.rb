ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# help them all
module TestHelpers
  def create_table!(params = {})
    post '/tables', table: { number: 1, seats: 2 }.merge(params)
  end

  def spawn_table!(params = {})
    Table.create!({ number: 1, seats: 2 }.merge(params))
  end

  def spawn_item!
    count = Item.count
    Item.create!(name: "Item #{count}", price: 1)
  end

  def spawn_order!(options = {})
    Order.create({
      table_id: options[:table_id],
      name: 'John Smith',
      email: 'order@email.com'
    }.merge(options))
  end

  def response_hash(response)
    JSON.parse(response.body)
  end
end

# help them all
module TestCase
  class ActiveSupport
    #fixtures :all
  end
end
