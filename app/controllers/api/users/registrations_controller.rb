class Api::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  before_action :configure_sign_up_params, only: [:create]

  def create
    Rails.logger.info "Params received: #{params.inspect}"

    build_resource(sign_up_params)

    if resource.save
      render json: {
        status: { code: 201, message: 'Signed up successfully.' },
        data: resource
      }, status: :created
    else
      render json: {
        status: { code: 422, message: "User could not be created." },
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
  end

  def sign_up_params
    user_data = params[:user] || params.dig(:registration, :user)
    user_data ||= {}

    ActionController::Parameters.new(user_data).permit(:email, :password, :password_confirmation)
  end
end
