class V1::AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :update, :destroy]

  # GET /v1/authors
  def index
    @authors = Author.page(params[:page]).per(params[:per_page])
    render json: {
      authors: AuthorSerializer.new(@authors).serializable_hash,
      pagination: pagination_metadata(@authors)
    }
  end

  # GET /v1/authors/1
  def show
    render json: AuthorSerializer.new(@author).serializable_hash

  end

  # POST /v1/authors
  def create
    @author = Author.new(author_params)
    if @author.save
      render json: AuthorSerializer.new(@author).serializable_hash, status: :created
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/authors/1
  def update
    if @author.update(author_params)
      render json: AuthorSerializer.new(@author).serializable_hash
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/authors/1
  def destroy
    @author.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_author
    @author = Author.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def author_params
    params.require(:author).permit(:name, :date_of_birth)
  end
end