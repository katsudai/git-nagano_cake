class Order < ApplicationRecord
    
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  enum payment_method: { "クレジットカード": 0, "銀行振込": 1 }
  
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }
  
end
