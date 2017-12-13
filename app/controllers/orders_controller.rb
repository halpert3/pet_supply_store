class OrdersController < ApplicationController
  include CurrentCart
  before_action :authenticate_user! #because we want them to be logged in before ordering
  before_action :set_cart, only: [:new, :create] #this gives this controller access to the cart
  
  def new
    if @cart.line_items.empty?
      redirect_to shop_url, notice: 'Your cart is empty.'
      return
    end
    
    @order = Order.new
    @order.user_id = current_user.id
  end
  
  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.add_line_items_from_cart(@cart)
    
    if @order.save
      Cart.destroy(session[:cart_id]) #if the order is succesful, we don't need the cart anymore. Kill in db.
      session[:cart_id] = nil #this destroys it in the session which is cookied in browser
      
      OrderConfirmationMailer.send_order_confirmation(current_user, @order).deliver_now
      
      redirect_to @order, notice: 'Thanks for your order' #still have to style and set up the order show view. 
    else
      render :new #gives the form again so they can try again
    end
  end
  
  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:name, :address, :pay_type, :user_id)
  end
  
end
