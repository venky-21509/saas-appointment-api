class ApplicationController < ActionController::API
  before_action :authenticate_request

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded

    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

  def render_unprocessable_entity(exception)
    render json: {
      error: exception.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { error: "Not Found" }, status: :not_found
  end
end
