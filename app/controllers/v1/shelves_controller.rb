class V1::ShelvesController < ApplicationController

  before_action :set_shelf, only: [:show, :update, :destroy]

  # GET /v1/shelves
  def index
    @shelves = Shelf.includes(:books).page(params[:page]).per(params[:per_page])
    render json: {
      Shleves: ShelfSerializer.new(@shelves).serializable_hash,
      pagination: pagination_metadata(@shelves)
    }
  end

  # GET /v1/shelves/1
  def show
    render json: ShelfSerializer.new(@shelf).serializable_hash
  end

  # POST /v1/shelves
  def create
    @shelf = Shelf.new(shelf_params)
    @shelf.number_of_books = 0
    if @shelf.save
      render json: ShelfSerializer.new(@shelf).serializable_hash, status: :created
    else
      render json: @shelf.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/shelves/1
  def update
    if @shelf.update!(shelf_params)
      render json: ShelfSerializer.new(@shelf).serializable_hash, status: :created
    else
      render json: @shelf.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/shelves/1
  def destroy
    @shelf.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_shelf
    @shelf = Shelf.includes(:books).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shelf_params
    params.require(:shelf).permit(:capacity, :code, :number_of_books)
  end
end
