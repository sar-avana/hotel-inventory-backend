class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authenticate_user!
    header = request.headers['Authorization']
    token = header&.split(' ')&.last

    begin
      decoded = JWT.decode(token, Rails.application.secret_key_base).first
      @current_user = User.find(decoded["user_id"])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end

