class Menu < ApplicationRecord
  has_many :reservation_menus, dependent: :destroy
  has_many :reservations, through: :reservation_menus, dependent: :destroy
end
