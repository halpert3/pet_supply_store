class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  
  PAYMENT_TYPES = ['Check', 'Credit Card', 'PayPal', 'COD', 'Wampum'].sort #all caps because it's a constant
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
     item.cart_id = nil #taking the item out of a cart
     line_items << item #thats's "push" symbol to array. This line puts the item back into an array called "line item" 
    end
  end
  
end

# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :text
#  pay_type   :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
