# control your table please
class TablesController < ApplicationController
  before_action :set_table, only: [:show, :update, :destroy]

  # GET /tables
  def index
    page = params[:page]
    per_page = 5
    @tables = Table.page(page).per(per_page).all

    render json: @tables
  end

  # GET /tables/1
  def show
    render json: @table
  end

  # POST /tables
  def create
    @table = Table.new(table_params)

    if @table.save
      render json: @table, status: :created, location: @table
    else
      render json: @table.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tables/1
  def update
    if @table.update(table_params)
      render json: @table
    else
      render json: @table.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tables/1
  def destroy
    @table.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_table
    @table = Table.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def table_params
    params.require(:table).permit(:number, :seats)
  end
end
