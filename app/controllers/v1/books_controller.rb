class V1::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /v1/books
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).includes(:author, :categories, :shelf).page(params[:page]).per(params[:per_page])
    render json: {
      Books: BookSerializer.new(@books).serializable_hash,
      pagination: pagination_metadata(@books)
    }
  end

  # GET /v1/books/1
  def show
    render json: BookSerializer.new(@book).serializable_hash
  end

  # POST /v1/books
  def create
    @book = Book.new(book_params)
    @book.review_count = 0
    @book.rating = 0
    if @book.save
      render json: BookSerializer.new(@book).serializable_hash, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/books/1
  def update
    if @book.update(book_params)
      render json: BookSerializer.new(@book).serializable_hash
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/books/1
  def destroy
    @book.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :author_id, :shelf_id, :stock, category_ids: [])
  end
end
