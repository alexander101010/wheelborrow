class ToolsController < ApplicationController
  before_action :find_tool, only: [:show, :create, :edit, :destroy]

  def index
    @tools = Tool.all
  end

  def show
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      redirect_to user_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @tool.update(tool_params)
  end

  def destroy
    @tool.destroy
    redirect_to user_path
  end

  private

  def tool_params
    params.require(:tool).permit(:description, :category)
  end

  def find_tool
    @tool = Tool.find(params[:id])
  end

end
