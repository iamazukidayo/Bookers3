class ReservationMenu < ApplicationRecord
  belongs_to :reservation
  belongs_to :menu
end
