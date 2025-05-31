class Api::Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    Rails.logger.info "Login params received: #{params.inspect}"

    user_data = params[:user] || params.dig(:session, :user)
    user_data ||= {}

    user = User.find_by(email: user_data[:email])

    if user && user.valid_password?(user_data[:password])
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
