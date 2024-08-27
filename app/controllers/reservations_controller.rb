class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @reservations = Reservation.where("day >= ?", Date.current)
                               .where("day < ?", Date.current >> 3)
                               .order(day: :desc)
  end

  def new
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    @start_time = DateTime.parse("#{@day} #{@time} JST")
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.start_time = Time.zone.parse(params[:reservation][:start_time])
    @reservation.user_id = current_user.id
    if @reservation.save
      # redirect_to reservation_path(@reservation), notice: '予約が作成されました。'
      Rails.logger.debug "Reservation created successfully: #{@reservation.inspect}"
      redirect_to reservation_path(@reservation.id)
    else
      render :new
    end
  end

  def today
    @reservations = Reservation.where(day: Date.today) # 今日の予約を取得
  end

  def destroy
    if @reservation.user == current_user
      if @reservation.day >= Date.today + 2.days
        @reservation.destroy
        redirect_to reservations_path, notice: '予約をキャンセルしました。'
      else
        redirect_to reservations_path, alert: '2日前を過ぎた予約は電話でのみキャンセルできます。'
      end
    else
      redirect_to root_path, alert: '他のユーザーの予約をキャンセルすることはできません。'
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time, menu_ids: [])
  end

  def check_reservation(reservations, day, time)
    start_time = DateTime.parse("#{day} #{time} JST")
    reservations.any? { |reservation| reservation.start_time == start_time }
  end
end
