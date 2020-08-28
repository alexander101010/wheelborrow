class BookingsController < ApplicationController
  before_action :find, only: [:show, :edit, :destroy, :confirm, :decline]
  def index
    @bookings = Booking.all
  end

  def show
  end

  def status?
    @booking.status
  end

  def cancel
    @booking = Booking.find(params[:format])
    @booking.status = "Cancelled"
    @booking.save
    flash[:notice] = "You have cancelled this booking request"
    # redirect_back(fallback_location: root_path)
  end

  def confirm
    @booking.status = "Accepted"
    @booking.save
    flash[:notice] = "You have accepted the pending booking request"
    redirect_back(fallback_location: root_path)
  end

  def decline
    @booking.status = "Declined"
    @booking.save
    flash[:notice] = "You have declined pending booking request"
    redirect_back(fallback_location: root_path)
  end

  def new
    @booking = Booking.new
    @tool = Tool.find(params[:tool_id])
  end

  def create
    @booking = Booking.new(params_format)
    @booking.tool = Tool.find(params[:tool_id])
    @booking.user = current_user
    @booking.status = 'Pending'

    if @booking.save
      redirect_to account_path
      flash[:notice] = "Your booking request has been processed!"
    else
      render :new
    end
  end

private

  def find
    @booking = Booking.find(params[:id])
  end

  def params_format
    params.require("booking").permit(:start_date, :end_date)
  end
end
