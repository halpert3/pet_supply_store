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
  
  
  def show
  end
end
