class Book < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  def get_image
    if image.attached?
      image
    else
      'noimage.jpg'
    end
  end
end
