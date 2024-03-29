class Item < ApplicationRecord
    
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  
  has_one_attached :image
  
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :introduction, presence: true
  validates :price, presence: true
  
  def with_tax_price
    (price*1.1).floor
  end
  
  def get_image(width, height)
    if image.attached?
      image.variant(resize_to_limit: [width, height]).processed
    else
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
  end
end
