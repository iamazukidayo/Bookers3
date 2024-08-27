class Reservation < ApplicationRecord
  belongs_to :user
  has_many :reservation_menus
  has_many :menus, through: :reservation_menus
  # belongs_to :menu

  validates :day, presence: true
  validates :time, presence: true
  # before_validation :calculate_end_time
  # before_save :set_end_time
  # validate :no_overlap

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

  # def calculate_end_time
    # if menu.present?
      # self.end_time = start_time + menu.duration.minutes
    # else
      # errors.add(:menu, "メニューが選択されていません")
    # end
  # end

  def check_reservation(reservations, day, time)
      start_time = DateTime.parse("#{day} #{time} JST")
      reservations.any? { |reservation| reservation.start_time == start_time }
  end


  private

  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time,  menu_ids: [])
  end


  # def set_end_time
    # self.end_time = start_time + menu.duration.minutes
  # end
end

  # def no_overlap
    # overlapping_reservations = Reservation.where("? < end_time AND start_time < ?", start_time, end_time)
    # if overlapping_reservations.exists?
      # errors.add(:base, "この時間帯は既に予約されています。")
    # end
  # end

