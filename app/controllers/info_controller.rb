class InfoController < ApplicationController
  def who_bought
    @product = Product.find(params[:id])
    @orders = @product.orders
    
    respond_to do |accepts|
      accepts.html 
      accepts.atom { render :layout => false }
      accepts.xml { render :layout => false,
                    :xml => @product.to_xml(:include => :orders) }
      accepts.json { render :layout => false ,
                   :json => @product.to_json(:include => :orders) }
    end
  end

protected

  def authorize
  end

end
