class Api::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  public

  def create
    Rails.logger.info "Params received: #{params.inspect}"

    build_resource(resource_params)

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
end
