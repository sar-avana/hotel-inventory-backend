class Api::Users::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      # ✅ Issue JWT token here
      token = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base)

      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        token: token,
        data: user
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: 'Invalid email or password.' }
      }, status: :unauthorized
    end
  end
end
