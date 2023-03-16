class Address < ApplicationRecord
    
  belongs_to :customer
  
  validates :postal_code, presence: true
  validates :addresses, presence: true
  validates :name, presence: true
  
  def address_display
  '〒' + postal_code + ' ' + addresses + ' ' + name
  end
end
