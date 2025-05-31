class Api::Users::SessionsController < Devise::SessionsController
  include ActionController::RequestForgeryProtection

  # ✅ Explicitly skip CSRF for JSON API logins
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, only: :create

  respond_to :json

  def create
    Rails.logger.info "Raw request body: #{request.raw_post}"
    Rails.logger.info "Parsed params: #{params.inspect}"

    user_params = params.require(:user).permit(:email, :password)
    user = User.find_by(email: user_params[:email])

    if user && user.valid_password?(user_params[:password])
      sign_in(:user, user)
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: user
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: 'Invalid email or password.' }
      }, status: :unauthorized
    end
  end

  def destroy
    sign_out(current_user)
    render json: {
      status: { code: 200, message: 'Logged out successfully.' }
    }, status: :ok
  end
end
