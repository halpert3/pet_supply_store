module CurrentCart
    extend ActiveSupport::Concern
    
    private
    
    def set_cart
       @cart = Cart.find(session[:cart_id]) #checks for existing cart
       rescue ActiveRecord::RecordNotFound #in case there's no cart, there would be an error, so this part creates one
        @cart = Cart.create
        session[:cart_id] = @cart.id
    end

    
end