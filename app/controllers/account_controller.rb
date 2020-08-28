class AccountController < ApplicationController
  def show
    @user = current_user
    @tools = @user.tools
    @review = Review.new
  end
end
