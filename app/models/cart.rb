class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy


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
