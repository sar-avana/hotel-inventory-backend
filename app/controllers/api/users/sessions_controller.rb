class Api::Users::SessionsController < Devise::SessionsController
    respond_to :json
  
    private
  
    def respond_with(resource, _opts = {})
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: resource
      }, status: :ok
    end
  
    def respond_to_on_destroy
      render json: { message: "Logged out successfully." }, status: :ok
    end
  end
  