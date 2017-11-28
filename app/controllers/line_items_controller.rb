class LineItemsController < ApplicationController
    include CurrentCart
    before_action :set_cart #we created this method in the conerns folder of controller
    
    def create
        product = Product.find(params[:product_id])
        @line_item = @cart.line_items.build(product: product, price: product.price)
        
        if @line_item.save #if saves OK
            flash[:notice] = "#{product.name} was added to your cart."
            redirect_to shop_path
        else
            flash.now[:notice] = "Couldn't add #{product.name} to your cart."
            redirect_back(fallback_location: shop_path)
        end
    end
    
end
