class StoreController < ApplicationController

before_filter :find_cart, :except => :empty_cart

def index

  #initialize
  @count = increment_count
  

  @time = Time.now
  @date = Date.today
  @products = Product.find_products_for_sale

  @cart = find_cart

  @current_item = nil
  
end



def increment_count
  session[:counter] ||= 0
  session[:counter] += 1
end

# def add_to_cart
#   @cart = find_cart
#  product = Product.find(params[:id])
#   @cart.add_product(product)
# end

def add_to_cart

  begin
  
    product = Product.find(params[:id])

  rescue ActiveRecord::RecordNotFound

    logger.error("Attempt to access invalid product #{params[:id]}")
    redirect_to_index("Invalid product")

  else

    @cart = find_cart

    @current_item = @cart.add_product(product)
    
    respond_to { |format| format.js }
  end

end


def empty_cart
  session[:cart] = nil
  @current_item = nil
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