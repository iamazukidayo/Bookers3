class Menu < ApplicationRecord
  has_many :reservation_menus
  has_many :reservations, through: :reservation_menus
end
