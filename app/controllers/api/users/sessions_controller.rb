class Api::Users::SessionsController < Devise::SessionsController
  respond_to :json

  # Override create to ensure params are permitted and user can be authenticated
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: resource
    }, status: :ok
  end

  # Override destroy if you want to add any custom logic
  def destroy
    super
  end

  private

  # Strong params - Devise uses this internally, but you can explicitly permit here
  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

  # respond_with is called on successful login (you can keep or customize)
  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: resource
    }, status: :ok
  end

  # respond_to_on_destroy is called on logout
  def respond_to_on_destroy
    render json: { message: "Logged out successfully." }, status: :ok
  end
end

  