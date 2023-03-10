class ApplicationController < ActionController::API
  include ActionController::Cookies

  def hello_world
    session[:count] = (session[:count] || 0) + 1
    render json: { count: session[:count] }
  end


  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def current_user
      @current_user ||= User.find_by_id(session[:user_id])
  end

  private

  def authorize
      render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
  end
  
  def render_not_found(exception)
      render json: {error: "#{exception.model} not found."}, status: :not_found
  end
  
  def render_unprocessable_entity_response(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

end
