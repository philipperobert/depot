require File.dirname(__FILE__) + '/../test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.

fixtures :products

# Let’s start by seeing what happens when we add a Ruby book 
# and a Rails book to our cart. We’d expect to end up with a 
# cart containing two items. The total price of items in the 
# cart should be the Ruby book’s price plus the Rails book’s
# price.

  def test_add_unique_products
    cart = Cart.new
    rails_book = products(:rails_book)
    ruby_book = products(:ruby_book)
    cart.add_product rails_book
    cart.add_product ruby_book
    assert_equal 2, cart.items.size
    assert_equal rails_book.price + ruby_book.price, cart.total_price
end


# Let’s write a second test, this time adding two Rails books to 
# the cart. Now we should see just one item in the cart, but 
# with a quantity of 2. 

def test_add_duplicate_product
    cart = Cart.new
    rails_book = products(:rails_book)
    cart.add_product rails_book
    cart.add_product rails_book
    assert_equal 2*rails_book.price, cart.total_price
    assert_equal 1, cart.items.size
    assert_equal 2, cart.items[0].quantity
  end


end

class CartTest < Test::Unit::TestCase
  fixtures :products
  
  def setup
    @cart = Cart.new
    @rails = products(:rails_book)
    @ruby = products(:ruby_book)
  end
  
  
  def test_add_unique_products
    @cart.add_product @rails
    @cart.add_product @ruby
    assert_equal 2, @cart.items.size
    assert_equal @rails.price + @ruby.price, @cart.total_price
  end
  
  def test_add_duplicate_product
    @cart.add_product @rails
    @cart.add_product @rails
    assert_equal 2*@rails.price, @cart.total_price
    assert_equal 1, @cart.items.size
    assert_equal 2, @cart.items[0].quantity
  end



  def Unit_Testing_Support
#
# As you write your unit tests, you’ll probably end up using most 
# of the assertions in the list that follows.

# assert(boolean,message)
#   Fails if boolean is false or nil.

assert(User.find_by_name("dave" ), "user 'dave' is missing" )

# assert_equal(expected, actual,message)
# assert_not_equal(expected, actual,message)
#   Fails unless expected and actual are/are not equal.
assert_equal(3, Product.count)
assert_not_equal(0, User.count, "no users in database" )


# assert_nil(object,message)
# assert_not_nil(object,message)
#   Fails unless object is/is not nil.
assert_nil(User.find_by_name("willard" ))
assert_not_nil(User.find_by_name("henry" ))


# assert_in_delta(expected_float, actual_float, delta,message)
# Fails unless the two floating-point numbers are within delta of each other.
# Preferred over assert_equal because floats are inexact.
assert_in_delta(1.33, line_item.discount, 0.005)


# assert_raise(Exception, ...,message) { block... }
# assert_nothing_raised(Exception, ...,message) { block... }
#   Fails unless the block raises/does not raise one of the listed exceptions.
assert_raise(ActiveRecord::RecordNotFound) { Product.find(bad_id) }

# assert_match(pattern, string,message)
# assert_no_match(pattern, string,message)
#   Fails unless string is matched/not matched by the regular expression in
#   pattern. If pattern is a string, then it is interpreted literally—no regular
#   expression metacharacters are honored.
assert_match(/flower/i, user.town)
assert_match("bang*flash" , user.company_name)


# assert_valid(activerecord_object)
#   Fails unless the supplied Active Record object is valid—that is, it passes
# its validations. If validation fails, the errors are reported as part of the
# assertion failure message.

user = Account.new(:name => "dave" , :email => 'secret@pragprog.com' )
assert_valid(user)

# flunk(message)
#   Fails unconditionally.
  unless user.valid? || account.valid?
    flunk("One of user or account should be valid" )
  end

# Ruby’s unit testing framework provides even more assertions, but these tend
# to be used infrequently when testing Rails applications, so we won’t discuss
# them here. You’ll find them in the documentation for Test::Unit.2 Additionally,
# Rails provides support for testing an application’s routing. We describe that
# starting on page 436.

end

end
