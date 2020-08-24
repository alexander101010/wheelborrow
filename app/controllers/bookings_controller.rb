class BookingsController < ApplicationController
  before_action :find

  def index
    @bookings = Booking.all
  end

  def show
    @booking
  end

  def status?
    @booking.status
  end

  def cancel
    @booking.status = "cancelled"
  end

  def confirm
    @booking.status = "confirmed"
  end

  def decline
    @booking.status = "declined"
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(params_format)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end



private

  def find
    @booking = booking.find(params[:id])
  end

  def params_format
    # TO BE UPDATED params.require(:cocktail).permit(:name, :photo)
  end
end
