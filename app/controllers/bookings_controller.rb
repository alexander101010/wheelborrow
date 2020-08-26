class BookingsController < ApplicationController
  before_action :find, only: [:show, :edit, :destroy]
  def index
    @bookings = Booking.all
  end

  def show
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
    @tool = Tool.find(params[:tool_id])
  end

  def create
    @booking = Booking.new(params_format)
    @booking.tool = Tool.find(params[:tool_id])
    @booking.user = current_user
    @booking.status = 'pending'

    if @booking.save
      redirect_to account_path
    else
      render :new
    end
  end

private

  def find
    @booking = booking.find(params[:id])
  end

  def params_format
    params.require("booking").permit(:start_date, :end_date)
  end
end
