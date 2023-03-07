class CartItem < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item
  
  def subtotal
    (item.with_tax_price).to_i * amount.to_i
  end
  
end
