require File.dirname(__FILE__) + '/../test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.

fixtures :products

# Now that we know what to test, we need to know how to tell 
# the test framework whether our code passes or fails. We do 
# that using assertions. An assertion is simply a method call that
# tells the framework what we expect to be true. The simplest 
# assertion is the method assert, which expects its argument to 
# be true. If it is, nothing special happens. However, if the 
# argument to assert is false, the assertion fails. The 
# framework will output a message and will stop executing the 
# test method containing the failure. In our case, we expect 
# that an empty Product model will not pass validation, so we can
# express that expectation by asserting that it isn’t valid.

def test_invalid_with_empty_attributes
  product = Product.new
  assert !product.valid?
  assert product.errors.invalid?(:title)
  assert product.errors.invalid?(:description)
  assert product.errors.invalid?(:price)
  assert product.errors.invalid?(:image_url)
end

# Clearly at this point we can dig deeper and exercise individual 
# validations. Let’s look at just three of the many possible tests.
# First, we’ll check that the validation of the price works the 
# way we expect.

def test_positive_price
  product = Product.new(:title => "My Book Title" ,
    :description => "yyy" ,
    :image_url => "zzz.jpg" )
  product.price = -1
  assert !product.valid?
  assert_equal "should be at least 0.01" , product.errors.on(:price)
  product.price = 0
  assert !product.valid?
  assert_equal "should be at least 0.01" , product.errors.on(:price)
  product.price = 1
  assert product.valid?
end


# Next, we’ll test that we’re validating the image URL ends with 
# one of .gif, .jpg, or .png.

# Here we’ve mixed things up a bit. Rather than write out the nine
# separate tests, we’ve used a couple of loops, one to check the 
# cases we expect to pass validation, the second to try cases we
# expect to fail. You’ll notice that we’ve also added an extra 
# parameter to our assert method calls. All of the testing 
# assertions accept an optional trailing parameter containing a 
# string. This will be written along with the error message if 
# the assertion fails and can be useful for diagnosing what 
# went wrong. Finally, our model contains a validation that checks
# that all the product titles in the database are unique. To test 
# this one, we’re going to need to store product data in the 
# database. One way to do this would be to have a test create a 
# product, save it, then create another product with the same 
# title, and try to save it too. This would clearly work. But 
# there’s a more idiomatic way—we can use Rails fixtures.

  def  test_image_url
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    ok.each do |name|
      product = Product.new(:title       => "My Book Title",
                            :description => "yyy",
                            :price       => 1,
                            :image_url   => name)
      assert product.valid?, product.errors.full_messages
    end

    bad.each do |name|
      product = Product.new(:title => "My Book Title",
                            :description => "yyy",
                            :price => 1,
                            :image_url => name)
      assert !product.valid?, "saving #{name}"
    end
  end
  
#
#
#
  
  def  test_unique_title
    product = Product.new(:title       => products(:ruby_book).title,
                          :description => "yyy", 
                          :price       => 1, 
                          :image_url   => "fred.gif")

    assert !product.save
    assert_equal "has already been taken", product.errors.on(:title)
  end
  


end
