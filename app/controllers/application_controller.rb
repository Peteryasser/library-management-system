class ApplicationController < ActionController::API


  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def pagination_metadata(paginated_collection)
    {
      current_page: paginated_collection.current_page,
      per_page: paginated_collection.limit_value,
      total_pages: paginated_collection.total_pages,
      total_count: paginated_collection.total_count
    }
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end
