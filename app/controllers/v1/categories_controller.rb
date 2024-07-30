class V1::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /v1/categories
  def index
    

    @categories = Category.page(params[:page]).per(params[:per_page])
    render json: {
      Categories: CategorySerializer.new(@categories).serializable_hash,
      pagination: pagination_metadata(@categories)
    }
  end

  # GET /v1/categories/1
  def show
    render json: CategorySerializer.new(@category).serializable_hash
  end

  # POST /v1/categories
  def create
    @category = Category.new(category_params)
    if @category.save
      render json: CategorySerializer.new(@category).serializable_hash, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/categories/1
  def update
    if @category.update(category_params)
      render json: CategorySerializer.new(@category).serializable_hash
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/categories/1
  def destroy
    @category.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name)
  end
end