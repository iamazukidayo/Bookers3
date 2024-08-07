module ReservationsHelper
  def times
    times = ["9:00",
             "9:30",
             "10:00",
             "10:30",
             "11:00",
             "11:30",
             "13:00",
             "13:30",
             "14:00",
             "14:30",
             "15:00",
             "15:30",
             "16:00",
             "16:30"]
  end

  def check_reservation(reservations, day, time)
    start_time = DateTime.parse("#{day} #{time} JST")
    reservations.any? { |reservation| reservation.start_time == start_time }
  end
end

