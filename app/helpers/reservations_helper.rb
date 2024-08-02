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
  
  # def check_reservation(reservations, day, time)
    # start_time = DateTime.parse("#{day} #{time} JST")
    # reservations.any? { |reservation| reservation.start_time == start_time }
  # end
  def check_reservation(reservations, day, time)
  # タイムゾーンを指定して、予約のstart_timeを比較するためにUTCに変換
    start_time = DateTime.parse("#{day} #{time} JST").in_time_zone("UTC")

  # 予約のstart_timeが一致するかどうかを確認
    reservations.any? { |reservation| reservation.start_time.in_time_zone("UTC") == start_time }
  end 
end

