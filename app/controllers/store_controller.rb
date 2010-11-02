class StoreController < ApplicationController

before_filter :find_cart, :except => :empty_cart

def index
  @time = Time.now
  @products = Product.find_products_for_sale
end


# def add_to_cart
#   @cart = find_cart
#  product = Product.find(params[:id])
#   @cart.add_product(product)
# end

  def add_to_cart

    product = Product.find(params[:id])

    @cart = find_cart

    @cart.add_product(product)
    
    redirect_to_index("Added product")

  rescue ActiveRecord::RecordNotFound

    logger.error("Attempt to access invalid product #{params[:id]}")

    redirect_to_index("Invalid product")

  end


def empty_cart
  session[:cart] = nil
  flash[:notice] = "Your cart is currently empty"
  redirect_to :action => :index
end



private


def find_cart
  @cart = (session[:cart] ||= Cart.new)
end


def redirect_to_index(msg)
  flash[:notice] = msg
  redirect_to :action => :index
end


protected

  def authorize
  end



end