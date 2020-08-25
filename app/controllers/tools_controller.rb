class ToolsController < ApplicationController
  before_action :find_tool, only: [:show, :edit, :destroy, :update]

  def index
    @tools = Tool.all
  end

  def show
  end

  def new
    @tool = Tool.new
  end

  def create
    raise
    @tool = Tool.new(tool_params)
    @tool.user = current_user
    if @tool.save
      redirect_to account_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tool.update(tool_params)
      redirect_to account_path
    else
      render :new
    end
  end

  def destroy
    @tool.destroy
    redirect_to account_path
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :description, :price, :category)
  end

  def find_tool
    @tool = Tool.find(params[:id])
  end
end
