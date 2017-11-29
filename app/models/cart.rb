class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy

    def add_product(x)
        product = Product.find(x)
        current_item = line_items.find_by(product_id: x) #what are these two variables? 
        
        if current_item
            current_item.quantity +=1
        else
            current_item = line_items.build(product: product, price: product.price)
        end
        
        current_item
    end

    def subtotal
    #     The Ruby Way:
    #       line_items.to_a.sum do |item|
    #         item.total #this is a ruby array method
    #       end
        line_items.select("SUM(quantity * price) AS sum")[0].sum
    end
    
   
end



# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
