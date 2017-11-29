class LineItemsController < ApplicationController
    include CurrentCart
    before_action :set_cart #we created this method in the concerns folder of controller
    
    def create
        product = Product.find(params[:product_id])
        @line_item = @cart.add_product(product.id)
        
        if @line_item.save #if saves OK
            flash[:notice] = "#{product.name} was added to your cart."
            redirect_to shop_path
        else
            flash.now[:notice] = "Couldn't add #{product.name} to your cart."
            redirect_back(fallback_location: shop_path)
        end
    end
   
   def destroy
     @line_item = LineItem.find(params[:id])
     @line_item.destroy
     redirect_to edit_cart_path
    end
    
end
