class ToolsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]
  before_action :find_tool, only: [:show, :edit, :destroy, :update]

  def index
    if !params[:tool][:query].present? && !params[:location][:query].present?
      @tools = Tool.all
      @users = User.all
    elsif !params[:location][:query].present?
      @users = []
      search_tools if params[:tool][:query].present?
      User.all.each do |user_result|
        @tool_results.each do |tool_result|
          if tool_result.searchable.user_id == user_result.id
            @tools << tool_result.searchable
            @users << user_result
          end
        end
      end
    elsif !params[:tool][:query].present?
      @tools = []
      search_location if params[:location][:query].present?
      @user_results.each do |user_result|
        Tool.all.each do |tool_result|
          if tool_result.user_id == user_result.searchable.id
            @tools << tool_result
            @users << user_result.searchable
          end
        end
      end
    else
      search_location if params[:location][:query].present?
      search_tools if params[:tool][:query].present?
      @user_results.each do |user_result|
        @tool_results.each do |tool_result|
          if tool_result.searchable.user_id == user_result.searchable.id
            @tools << tool_result.searchable
            @users << user_result.searchable
          end
        end
      end
    end

        @markers = @users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude
      }
    end
  end

  def search_location
    @users = []
    @user_results = PgSearch.multisearch(params[:location][:query])
  end

  def search_tools
    @tools = []
    @tool_results = PgSearch.multisearch(params[:tool][:query])
  end

  def show
    @marker =
      [{
        lat: @tool.user.latitude,
        lng: @tool.user.longitude
      }]
    if @tool.reviews.length > 0
      @average_rating = @tool.average_rating(@tool)
    else
      @average_rating = "No reviews."
    end
  end

  def new
    @tool = Tool.new
  end

  def create
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
    params.require(:tool).permit(:name, :description, :price, :category, :photo)
  end

  def find_tool
    @tool = Tool.find(params[:id])
  end
end
