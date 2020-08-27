class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @tool = Tool.find(params[:tool_id])
  end

  def create
    @review = Review.new(review_params)
    tool = Tool.find(params[:tool_id])
    @review.tool = tool
    if @review.save
      redirect_to tool_path(tool)
      flash[:alert] = "Review created."
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
