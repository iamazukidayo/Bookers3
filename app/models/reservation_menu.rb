class ReservationMenu < ApplicationRecord
  belongs_to :reservation, dependent: :destroy
  belongs_to :menu, dependent: :destroy
end
