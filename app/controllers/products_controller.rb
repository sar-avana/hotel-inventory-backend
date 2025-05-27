class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      status: 200,
      message: "Welcome #{current_user.email}, here are your products!",
      products: [
        { id: 1, name: "Apples", price: 100 },
        { id: 2, name: "Bananas", price: 50 }
      ]
    }
  end
end

