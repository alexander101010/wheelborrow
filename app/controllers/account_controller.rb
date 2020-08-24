class AccountController < ApplicationController
  def show
    @user = current_user
    @tools = @user.tools
  end
end
