class Book < ApplicationRecord
  
  has_one_attached :image
  belongs_to :user


  def get_image
    if image.attached?
      image
    else 
      'noimage.jpg'
    end 
  end 
end 
    