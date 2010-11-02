class StoreController < ApplicationController

def index
@time = Time.now
@products = Product.find_products_for_sale
end

end
