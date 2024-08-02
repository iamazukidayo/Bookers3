class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
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
      Rails.logger.debug "Reservation created successfully: #{@reservation.inspect}"
      redirect_to reservation_path(@reservation.id)
    else
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time)
  end

  def check_reservation(reservations, day, time)
    start_time = DateTime.parse("#{day} #{time} JST")
    reservations.any? { |reservation| reservation.start_time == start_time }
  end
end

