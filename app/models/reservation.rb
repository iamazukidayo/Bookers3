class Reservation < ApplicationRecord
  belongs_to :user

  validates :day, presence: true
  validates :time, presence: true

  def self.reservations_after_three_month
    reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
    reservation_data = []
    reservations.each do |reservation|
      reservations_hash = {}
      reservations_hash.merge!(day: reservation.day.strftime("%Y-%m-%d"), time: reservation.time)
      reservation_data.push(reservations_hash)
    end
    reservation_data
  end
  
  def cancelable
    if self.day < Date.today + 2.days && self.status_changed? && self.status == 'キャンセル済み'
      errors.add(:status, '2日前を過ぎた予約はキャンセルできません。')
    end
  end 
end
