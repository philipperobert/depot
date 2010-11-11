require File.dirname(__FILE__) + '/../test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.

fixtures :products


  def test_add_unique_products
    cart = Cart.new
    rails_book = products(:rails_book)
    ruby_book = products(:ruby_book)
    cart.add_product rails_book
    cart.add_product ruby_book
    assert_equal 2, cart.items.size
    assert_equal rails_book.price + ruby_book.price, cart.total_price
end

end
