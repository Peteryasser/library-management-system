class ApplicationController < ActionController::API

  #before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
  
    if token.blank?
      render json: { errors: 'Token not provided' }, status: :unauthorized and return
    end
  
    decoded_token = JsonWebToken.decode(token)
  
    if decoded_token.nil?
      render json: { errors: 'Invalid token' }, status: :unauthorized and return
    end
  
    @current_user = User.find(decoded_token[:user_id])
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    render json: { errors: 'Unauthorized access' }, status: :unauthorized
  end
  

  def current_user
    @current_user
  end

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
