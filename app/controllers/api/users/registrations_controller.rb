class Api::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # Strong parameters - must permit user params explicitly
  private

  def sign_up_params
      # Check if params[:user] exists, else fallback to params[:registration][:user]
    if params[:user].present?
      params.require(:user).permit(:email, :password, :password_confirmation)
    else
      params.require(:registration).require(:user).permit(:email, :password, :password_confirmation)
    end
  end

  public

  def create
    Rails.logger.info "Params received: #{params.inspect}"  # Add this line

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

end
